import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/check_in.dart';
import '../../domain/entities/emotional_calendar_entry.dart';
import '../../domain/entities/dashboard.dart';
import '../../domain/usecases/create_check_in_usecase.dart';
import '../../domain/usecases/get_check_ins_usecase.dart';
import '../../domain/usecases/get_today_check_in_usecase.dart';
import '../../domain/usecases/create_emotional_calendar_entry_usecase.dart';
import '../../domain/usecases/get_emotional_calendar_usecase.dart';
import '../../domain/usecases/get_dashboard_usecase.dart';
import '../../../../core/usecases/usecase.dart';

// ============= STATE CLASSES =============

class TrackingState {
  final bool isLoading;
  final String? error;
  final TodayCheckIn? todayCheckIn;
  final CheckInHistory? checkInHistory;
  final EmotionalCalendar? emotionalCalendar;
  final TrackingDashboard? dashboard;
  final bool isLoadingHistory;

  TrackingState({
    this.isLoading = false,
    this.error,
    this.todayCheckIn,
    this.checkInHistory,
    this.emotionalCalendar,
    this.dashboard,
    this.isLoadingHistory = false,
  });

  TrackingState copyWith({
    bool? isLoading,
    String? error,
    TodayCheckIn? todayCheckIn,
    CheckInHistory? checkInHistory,
    EmotionalCalendar? emotionalCalendar,
    TrackingDashboard? dashboard,
    bool? isLoadingHistory,
  }) {
    return TrackingState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      todayCheckIn: todayCheckIn ?? this.todayCheckIn,
      checkInHistory: checkInHistory ?? this.checkInHistory,
      emotionalCalendar: emotionalCalendar ?? this.emotionalCalendar,
      dashboard: dashboard ?? this.dashboard,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
    );
  }
}

class CheckInFormState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  CheckInFormState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  CheckInFormState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return CheckInFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class EmotionalCalendarFormState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  EmotionalCalendarFormState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  EmotionalCalendarFormState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return EmotionalCalendarFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// ============= TRACKING NOTIFIER =============

class TrackingNotifier extends StateNotifier<TrackingState> {
  final CreateCheckInUseCase _createCheckInUseCase;
  final GetCheckInsUseCase _getCheckInsUseCase;
  final GetTodayCheckInUseCase _getTodayCheckInUseCase;
  final CreateEmotionalCalendarEntryUseCase _createEmotionalCalendarEntryUseCase;
  final GetEmotionalCalendarUseCase _getEmotionalCalendarUseCase;
  final GetDashboardUseCase _getDashboardUseCase;

  TrackingNotifier({
    required CreateCheckInUseCase createCheckInUseCase,
    required GetCheckInsUseCase getCheckInsUseCase,
    required GetTodayCheckInUseCase getTodayCheckInUseCase,
    required CreateEmotionalCalendarEntryUseCase createEmotionalCalendarEntryUseCase,
    required GetEmotionalCalendarUseCase getEmotionalCalendarUseCase,
    required GetDashboardUseCase getDashboardUseCase,
  })  : _createCheckInUseCase = createCheckInUseCase,
        _getCheckInsUseCase = getCheckInsUseCase,
        _getTodayCheckInUseCase = getTodayCheckInUseCase,
        _createEmotionalCalendarEntryUseCase = createEmotionalCalendarEntryUseCase,
        _getEmotionalCalendarUseCase = getEmotionalCalendarUseCase,
        _getDashboardUseCase = getDashboardUseCase,
        super(TrackingState());

  // ============= LOAD INITIAL DATA =============

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);

    final todayCheckInResult = await _getTodayCheckInUseCase(NoParams());
    final emotionalCalendarResult = await _getEmotionalCalendarUseCase(
      GetEmotionalCalendarParams(),
    );
    final checkInHistoryResult = await _getCheckInsUseCase(
      GetCheckInsParams(),
    );
    final dashboardResult = await _getDashboardUseCase(
      GetDashboardParams(days: 7),
    );

    todayCheckInResult.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (todayCheckIn) {
        emotionalCalendarResult.fold(
          (failure) => state = state.copyWith(
            isLoading: false,
            error: failure.message,
          ),
          (emotionalCalendar) {
            checkInHistoryResult.fold(
              (failure) => state = state.copyWith(
                isLoading: false,
                error: failure.message,
              ),
              (checkInHistory) {
                dashboardResult.fold(
                  (failure) => state = state.copyWith(
                    isLoading: false,
                    error: failure.message,
                  ),
                  (dashboard) {
                    state = state.copyWith(
                      isLoading: false,
                      todayCheckIn: todayCheckIn,
                      emotionalCalendar: emotionalCalendar,
                      checkInHistory: checkInHistory,
                      dashboard: dashboard,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  // ============= REFRESH DATA =============

  Future<void> refreshData() async {
    await loadInitialData();
  }

  // ============= LOAD TODAY CHECK-IN =============

  Future<void> loadTodayCheckIn() async {
    final result = await _getTodayCheckInUseCase(NoParams());

    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (todayCheckIn) => state = state.copyWith(todayCheckIn: todayCheckIn),
    );
  }

  // ============= LOAD EMOTIONAL CALENDAR =============

  Future<void> loadEmotionalCalendar({
    String? startDate,
    String? endDate,
  }) async {
    final result = await _getEmotionalCalendarUseCase(
      GetEmotionalCalendarParams(startDate: startDate, endDate: endDate),
    );

    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (emotionalCalendar) => state = state.copyWith(
        emotionalCalendar: emotionalCalendar,
      ),
    );
  }

  // ============= LOAD CHECK-IN HISTORY =============

  Future<void> loadCheckInHistory({
    String? startDate,
    String? endDate,
    int? pageNumber,
    int? pageSize,
  }) async {
    state = state.copyWith(isLoadingHistory: true);

    final result = await _getCheckInsUseCase(
      GetCheckInsParams(
        startDate: startDate,
        endDate: endDate,
        pageNumber: pageNumber,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoadingHistory: false,
        error: failure.message,
      ),
      (checkInHistory) => state = state.copyWith(
        isLoadingHistory: false,
        checkInHistory: checkInHistory,
      ),
    );
  }

  // ============= LOAD DASHBOARD =============

  Future<void> loadDashboard({int? days}) async {
    final result = await _getDashboardUseCase(
      GetDashboardParams(days: days),
    );

    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (dashboard) => state = state.copyWith(dashboard: dashboard),
    );
  }
}

// ============= CHECK-IN FORM NOTIFIER =============

class CheckInFormNotifier extends StateNotifier<CheckInFormState> {
  final CreateCheckInUseCase _createCheckInUseCase;

  CheckInFormNotifier({
    required CreateCheckInUseCase createCheckInUseCase,
  })  : _createCheckInUseCase = createCheckInUseCase,
        super(CheckInFormState());

  Future<void> createCheckIn({
    required int emotionalLevel,
    required int energyLevel,
    required String moodDescription,
    required int sleepHours,
    required List<String> symptoms,
    String? notes,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    final result = await _createCheckInUseCase(
      CreateCheckInParams(
        emotionalLevel: emotionalLevel,
        energyLevel: energyLevel,
        moodDescription: moodDescription,
        sleepHours: sleepHours,
        symptoms: symptoms,
        notes: notes,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
        isSuccess: false,
      ),
      (checkIn) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      ),
    );
  }

  void reset() {
    state = CheckInFormState();
  }
}

// ============= EMOTIONAL CALENDAR FORM NOTIFIER =============

class EmotionalCalendarFormNotifier extends StateNotifier<EmotionalCalendarFormState> {
  final CreateEmotionalCalendarEntryUseCase _createEmotionalCalendarEntryUseCase;

  EmotionalCalendarFormNotifier({
    required CreateEmotionalCalendarEntryUseCase createEmotionalCalendarEntryUseCase,
  })  : _createEmotionalCalendarEntryUseCase = createEmotionalCalendarEntryUseCase,
        super(EmotionalCalendarFormState());

  Future<void> createEmotionalCalendarEntry({
    required String date,
    required String emotionalEmoji,
    required int moodLevel,
    required List<String> emotionalTags,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    final result = await _createEmotionalCalendarEntryUseCase(
      CreateEmotionalCalendarEntryParams(
        date: date,
        emotionalEmoji: emotionalEmoji,
        moodLevel: moodLevel,
        emotionalTags: emotionalTags,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
        isSuccess: false,
      ),
      (entry) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      ),
    );
  }

  void reset() {
    state = EmotionalCalendarFormState();
  }
}

// ============= PROVIDERS =============

// Necesitarás inyectar las dependencias aquí
// Esto depende de tu setup de DI (get_it, riverpod, etc.)

final trackingProvider = StateNotifierProvider<TrackingNotifier, TrackingState>((ref) {
  // TODO: Inyectar use cases desde tu DI container
  throw UnimplementedError('Inject use cases here');
});

final checkInFormProvider = StateNotifierProvider<CheckInFormNotifier, CheckInFormState>((ref) {
  // TODO: Inyectar use cases desde tu DI container
  throw UnimplementedError('Inject use cases here');
});

final emotionalCalendarFormProvider = 
    StateNotifierProvider<EmotionalCalendarFormNotifier, EmotionalCalendarFormState>((ref) {
  // TODO: Inyectar use cases desde tu DI container
  throw UnimplementedError('Inject use cases here');
});