import 'package:equatable/equatable.dart';
import '../../../../domain/models/patient_profile.dart';
import '../../../../../tracking/domain/entities/check_in.dart';
import '../../../../../library/domain/models/assignment.dart';

class PatientDetailState extends Equatable {
  final bool isLoading;
  final PatientProfile? profile;
  final String? profileError;
  
  final bool checkInsLoading;
  final CheckIn? lastCheckIn;
  final List<double> weeklyChartLineData;
  final List<double> weeklyChartColumnData;
  final String? checkInsError;
  
  final bool assignmentsLoading;
  final List<Assignment> assignments;
  final int pendingCount;
  final int completedCount;
  final String? assignmentsError;
  
  final String startDate;

  const PatientDetailState({
    this.isLoading = true,
    this.profile,
    this.profileError,
    this.checkInsLoading = true,
    this.lastCheckIn,
    this.weeklyChartLineData = const [0, 0, 0, 0, 0, 0, 0],
    this.weeklyChartColumnData = const [0, 0, 0, 0, 0, 0, 0],
    this.checkInsError,
    this.assignmentsLoading = true,
    this.assignments = const [],
    this.pendingCount = 0,
    this.completedCount = 0,
    this.assignmentsError,
    this.startDate = '',
  });

  PatientDetailState copyWith({
    bool? isLoading,
    PatientProfile? profile,
    String? profileError,
    bool? checkInsLoading,
    CheckIn? lastCheckIn,
    List<double>? weeklyChartLineData,
    List<double>? weeklyChartColumnData,
    String? checkInsError,
    bool? assignmentsLoading,
    List<Assignment>? assignments,
    int? pendingCount,
    int? completedCount,
    String? assignmentsError,
    String? startDate,
  }) {
    return PatientDetailState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      profileError: profileError ?? this.profileError,
      checkInsLoading: checkInsLoading ?? this.checkInsLoading,
      lastCheckIn: lastCheckIn ?? this.lastCheckIn,
      weeklyChartLineData: weeklyChartLineData ?? this.weeklyChartLineData,
      weeklyChartColumnData: weeklyChartColumnData ?? this.weeklyChartColumnData,
      checkInsError: checkInsError ?? this.checkInsError,
      assignmentsLoading: assignmentsLoading ?? this.assignmentsLoading,
      assignments: assignments ?? this.assignments,
      pendingCount: pendingCount ?? this.pendingCount,
      completedCount: completedCount ?? this.completedCount,
      assignmentsError: assignmentsError ?? this.assignmentsError,
      startDate: startDate ?? this.startDate,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    profile,
    profileError,
    checkInsLoading,
    lastCheckIn,
    weeklyChartLineData,
    weeklyChartColumnData,
    checkInsError,
    assignmentsLoading,
    assignments,
    pendingCount,
    completedCount,
    assignmentsError,
    startDate,
  ];
}