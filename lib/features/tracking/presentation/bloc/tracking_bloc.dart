import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_check_in_usecase.dart';
import '../../domain/usecases/get_check_ins_usecase.dart';
import '../../domain/usecases/get_today_check_in_usecase.dart';
import '../../domain/usecases/create_emotional_calendar_entry_usecase.dart';
import '../../domain/usecases/get_emotional_calendar_usecase.dart';
import '../../domain/usecases/get_dashboard_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final CreateCheckInUseCase createCheckInUseCase;
  final GetCheckInsUseCase getCheckInsUseCase;
  final GetTodayCheckInUseCase getTodayCheckInUseCase;
  final CreateEmotionalCalendarEntryUseCase createEmotionalCalendarEntryUseCase;
  final GetEmotionalCalendarUseCase getEmotionalCalendarUseCase;
  final GetDashboardUseCase getDashboardUseCase;

  TrackingBloc({
    required this.createCheckInUseCase,
    required this.getCheckInsUseCase,
    required this.getTodayCheckInUseCase,
    required this.createEmotionalCalendarEntryUseCase,
    required this.getEmotionalCalendarUseCase,
    required this.getDashboardUseCase,
  }) : super(TrackingInitial()) {
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<RefreshDataEvent>(_onRefreshData);
    on<LoadTodayCheckInEvent>(_onLoadTodayCheckIn);
    on<LoadEmotionalCalendarEvent>(_onLoadEmotionalCalendar);
    on<LoadCheckInHistoryEvent>(_onLoadCheckInHistory);
    on<LoadDashboardEvent>(_onLoadDashboard);
    on<CreateCheckInEvent>(_onCreateCheckIn);
    on<CreateEmotionalCalendarEntryEvent>(_onCreateEmotionalCalendarEntry);
  }

  Future<void> _onLoadInitialData(
    LoadInitialDataEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLoading());

    final todayCheckInResult = await getTodayCheckInUseCase(NoParams());
    final emotionalCalendarResult = await getEmotionalCalendarUseCase(
      GetEmotionalCalendarParams(),
    );
    final checkInHistoryResult = await getCheckInsUseCase(
      GetCheckInsParams(),
    );
    final dashboardResult = await getDashboardUseCase(
      GetDashboardParams(days: 7),
    );

    todayCheckInResult.fold(
      (failure) => emit(TrackingError(failure.message)),
      (todayCheckIn) {
        emotionalCalendarResult.fold(
          (failure) => emit(TrackingError(failure.message)),
          (emotionalCalendar) {
            checkInHistoryResult.fold(
              (failure) => emit(TrackingError(failure.message)),
              (checkInHistory) {
                dashboardResult.fold(
                  (failure) => emit(TrackingError(failure.message)),
                  (dashboard) {
                    emit(TrackingLoaded(
                      todayCheckIn: todayCheckIn,
                      emotionalCalendar: emotionalCalendar,
                      checkInHistory: checkInHistory,
                      dashboard: dashboard,
                    ));
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _onRefreshData(
    RefreshDataEvent event,
    Emitter<TrackingState> emit,
  ) async {
    add(LoadInitialDataEvent());
  }

  Future<void> _onLoadTodayCheckIn(
    LoadTodayCheckInEvent event,
    Emitter<TrackingState> emit,
  ) async {
    final result = await getTodayCheckInUseCase(NoParams());

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (todayCheckIn) {
        if (state is TrackingLoaded) {
          emit((state as TrackingLoaded).copyWith(
            todayCheckIn: todayCheckIn,
          ));
        }
      },
    );
  }

  Future<void> _onLoadEmotionalCalendar(
    LoadEmotionalCalendarEvent event,
    Emitter<TrackingState> emit,
  ) async {
    final result = await getEmotionalCalendarUseCase(
      GetEmotionalCalendarParams(
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (emotionalCalendar) {
        if (state is TrackingLoaded) {
          emit((state as TrackingLoaded).copyWith(
            emotionalCalendar: emotionalCalendar,
          ));
        } else {
          emit(TrackingLoaded(emotionalCalendar: emotionalCalendar));
        }
      },
    );
  }

  Future<void> _onLoadCheckInHistory(
    LoadCheckInHistoryEvent event,
    Emitter<TrackingState> emit,
  ) async {
    final result = await getCheckInsUseCase(
      GetCheckInsParams(
        startDate: event.startDate,
        endDate: event.endDate,
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
      ),
    );

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (checkInHistory) {
        if (state is TrackingLoaded) {
          emit((state as TrackingLoaded).copyWith(
            checkInHistory: checkInHistory,
          ));
        } else {
          emit(TrackingLoaded(checkInHistory: checkInHistory));
        }
      },
    );
  }

  Future<void> _onLoadDashboard(
    LoadDashboardEvent event,
    Emitter<TrackingState> emit,
  ) async {
    final result = await getDashboardUseCase(
      GetDashboardParams(days: event.days),
    );

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (dashboard) {
        if (state is TrackingLoaded) {
          emit((state as TrackingLoaded).copyWith(
            dashboard: dashboard,
          ));
        } else {
          emit(TrackingLoaded(dashboard: dashboard));
        }
      },
    );
  }

  Future<void> _onCreateCheckIn(
    CreateCheckInEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(CheckInFormLoading());

    final result = await createCheckInUseCase(
      CreateCheckInParams(
        emotionalLevel: event.emotionalLevel,
        energyLevel: event.energyLevel,
        moodDescription: event.moodDescription,
        sleepHours: event.sleepHours,
        symptoms: event.symptoms,
        notes: event.notes,
      ),
    );

    result.fold(
      (failure) => emit(CheckInFormError(failure.message)),
      (checkIn) => emit(CheckInFormSuccess()),
    );
  }

  Future<void> _onCreateEmotionalCalendarEntry(
    CreateEmotionalCalendarEntryEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(EmotionalCalendarFormLoading());

    final result = await createEmotionalCalendarEntryUseCase(
      CreateEmotionalCalendarEntryParams(
        date: event.date,
        emotionalEmoji: event.emotionalEmoji,
        moodLevel: event.moodLevel,
        emotionalTags: event.emotionalTags,
      ),
    );

    result.fold(
      (failure) => emit(EmotionalCalendarFormError(failure.message)),
      (entry) => emit(EmotionalCalendarFormSuccess()),
    );
  }
}