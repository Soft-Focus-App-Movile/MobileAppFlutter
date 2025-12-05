import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../library/data/services/content_search_service.dart';
import '../../../../library/data/services/assignments_service.dart';
import '../../../../library/data/models/request/content_search_request_dto.dart';
import '../../../../therapy/data/services/therapy_service.dart';
import '../../../../profiles/data/remote/profile_service.dart';
import 'patient_home_event.dart';
import 'patient_home_state.dart';

class PatientHomeBloc extends Bloc<PatientHomeEvent, PatientHomeState> {
  final ContentSearchService _contentSearchService;
  final TherapyService _therapyService;
  final ProfileService _profileService;
  final AssignmentsService _assignmentsService;

  static const int resultsPerSearch = 15;
  static const List<String> movieKeywords = [
    'inspirational',
    'feel-good',
    'hope',
    'friendship',
    'family',
    'uplifting'
  ];
  static const List<String> musicKeywords = [
    'meditation',
    'relaxing',
    'peaceful',
    'healing',
    'soothing',
    'calming'
  ];

  int _currentKeywordIndex = 0;

  PatientHomeBloc({
    required ContentSearchService contentSearchService,
    required TherapyService therapyService,
    required ProfileService profileService,
    required AssignmentsService assignmentsService,
  })  : _contentSearchService = contentSearchService,
        _therapyService = therapyService,
        _profileService = profileService,
        _assignmentsService = assignmentsService,
        super(PatientHomeInitial()) {
    on<LoadPatientHomeData>(_onLoadPatientHomeData);
    on<RefreshRecommendations>(_onRefreshRecommendations);
    on<RetryTherapist>(_onRetryTherapist);
    on<RetryAssignments>(_onRetryAssignments);
  }

  Future<void> _onLoadPatientHomeData(
    LoadPatientHomeData event,
    Emitter<PatientHomeState> emit,
  ) async {
    emit(PatientHomeLoading());

    final recommendationsState = RecommendationsLoading();
    final therapistState = TherapistLoading();
    final assignmentsState = AssignmentsLoading();

    emit(PatientHomeLoaded(
      recommendationsState: recommendationsState,
      therapistState: therapistState,
      assignmentsState: assignmentsState,
    ));

    // Load all data in parallel
    _loadRecommendations(emit);
    _loadTherapistInfo(emit);
    _loadAssignments(emit);
  }

  Future<void> _onRefreshRecommendations(
    RefreshRecommendations event,
    Emitter<PatientHomeState> emit,
  ) async {
    if (state is PatientHomeLoaded) {
      final currentState = state as PatientHomeLoaded;
      emit(currentState.copyWith(
        recommendationsState: RecommendationsLoading(),
      ));
      _loadRecommendations(emit);
    }
  }

  Future<void> _onRetryTherapist(
    RetryTherapist event,
    Emitter<PatientHomeState> emit,
  ) async {
    if (state is PatientHomeLoaded) {
      final currentState = state as PatientHomeLoaded;
      emit(currentState.copyWith(
        therapistState: TherapistLoading(),
      ));
      _loadTherapistInfo(emit);
    }
  }

  Future<void> _onRetryAssignments(
    RetryAssignments event,
    Emitter<PatientHomeState> emit,
  ) async {
    if (state is PatientHomeLoaded) {
      final currentState = state as PatientHomeLoaded;
      emit(currentState.copyWith(
        assignmentsState: AssignmentsLoading(),
      ));
      _loadAssignments(emit);
    }
  }

  Future<void> _loadRecommendations(Emitter<PatientHomeState> emit) async {
    try {
      final allContent = [];

      // Search for movies and music
      final movieKeyword = _getNextKeyword(movieKeywords);
      final musicKeyword = _getNextKeyword(musicKeywords);

      // Search movies
      try {
        final movieRequest = ContentSearchRequestDto(
          query: movieKeyword,
          contentType: 'Movie',
          limit: resultsPerSearch,
        );
        final movieResponse =
            await _contentSearchService.searchContent(movieRequest);
        final movieContent = movieResponse.results.map((dto) => dto.toDomain()).toList();
        allContent.addAll(movieContent);
      } catch (e) {
        // Logging framework would be better
      }

      // Search music
      try {
        final musicRequest = ContentSearchRequestDto(
          query: musicKeyword,
          contentType: 'Music',
          limit: resultsPerSearch,
        );
        final musicResponse =
            await _contentSearchService.searchContent(musicRequest);
        final musicContent = musicResponse.results.map((dto) => dto.toDomain()).toList();
        allContent.addAll(musicContent);
      } catch (e) {
        // Logging framework would be better
      }

      // Filter content with valid images and shuffle
      final contentWithImages = allContent.where((item) {
        return item.posterUrl != null && item.posterUrl!.isNotEmpty ||
            item.backdropUrl != null && item.backdropUrl!.isNotEmpty ||
            item.thumbnailUrl != null && item.thumbnailUrl!.isNotEmpty ||
            item.photoUrl != null && item.photoUrl!.isNotEmpty;
      }).toList()
        ..shuffle();

      if (state is PatientHomeLoaded) {
        final currentState = state as PatientHomeLoaded;
        emit(currentState.copyWith(
          recommendationsState: contentWithImages.isEmpty
              ? RecommendationsEmpty()
              : RecommendationsSuccess(contentWithImages),
        ));
      }
    } catch (e) {
      if (state is PatientHomeLoaded) {
        final currentState = state as PatientHomeLoaded;
        emit(currentState.copyWith(
          recommendationsState: RecommendationsError(e.toString()),
        ));
      }
    }
  }

  Future<void> _loadTherapistInfo(Emitter<PatientHomeState> emit) async {
    try {
      final relationshipResponse = await _therapyService.getMyRelationship();
      final relationship = relationshipResponse.relationship?.toDomain();

      if (relationship != null && relationship.isActive) {
        try {
          final psychologistResponse =
              await _profileService.getPsychologistById(relationship.psychologistId);
          final psychologist = psychologistResponse.toDomain();

          // Try to get last message
          String? lastMessage;
          String? lastMessageTime;

          try {
            final lastMessageResponse =
                await _therapyService.getLastReceivedMessage();
            if (lastMessageResponse != null) {
              final chatMessage = lastMessageResponse.toDomain();
              lastMessage = chatMessage.content;
              lastMessageTime = _formatMessageTime(chatMessage.timestamp.toIso8601String());
            }
          } catch (e) {
            // Logging framework would be better
          }

          if (state is PatientHomeLoaded) {
            final currentState = state as PatientHomeLoaded;
            emit(currentState.copyWith(
              therapistState: TherapistSuccess(
                psychologist: psychologist,
                lastMessage: lastMessage,
                lastMessageTime: lastMessageTime,
              ),
            ));
          }
        } catch (e) {
          if (state is PatientHomeLoaded) {
            final currentState = state as PatientHomeLoaded;
            emit(currentState.copyWith(
              therapistState: TherapistError(e.toString()),
            ));
          }
        }
      } else {
        if (state is PatientHomeLoaded) {
          final currentState = state as PatientHomeLoaded;
          emit(currentState.copyWith(
            therapistState: NoTherapist(),
          ));
        }
      }
    } catch (e) {
      if (state is PatientHomeLoaded) {
        final currentState = state as PatientHomeLoaded;
        emit(currentState.copyWith(
          therapistState: TherapistError(e.toString()),
        ));
      }
    }
  }

  Future<void> _loadAssignments(Emitter<PatientHomeState> emit) async {
    try {
      final response = await _assignmentsService.getAssignedContent(completed: false);
      final assignments = response.assignments.map((dto) {
        final domain = dto.toDomain();
        return domain;
      }).toList();

      final pending = response.pending;
      final completed = response.completed;

      if (state is PatientHomeLoaded) {
        final currentState = state as PatientHomeLoaded;
        emit(currentState.copyWith(
          assignmentsState: AssignmentsSuccess(
            assignments: assignments,
            pendingCount: pending,
            completedCount: completed,
          ),
        ));
      }
    } catch (e) {
      if (state is PatientHomeLoaded) {
        final currentState = state as PatientHomeLoaded;
        emit(currentState.copyWith(
          assignmentsState: AssignmentsError(e.toString()),
        ));
      }
    }
  }

  String _getNextKeyword(List<String> keywords) {
    final keyword = keywords[_currentKeywordIndex % keywords.length];
    _currentKeywordIndex++;
    return keyword;
  }

  String _formatMessageTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final formatter = DateFormat('h:mma');
      return formatter.format(dateTime).toLowerCase();
    } catch (e) {
      return 'Ahora';
    }
  }
}
