import 'package:equatable/equatable.dart';
import '../../../../domain/models/patient_directory_item.dart';

abstract class PatientListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PatientListInitial extends PatientListState {}

class PatientListLoading extends PatientListState {}

class PatientListLoaded extends PatientListState {
  final List<PatientDirectoryItem> patients;

  PatientListLoaded(this.patients);

  @override
  List<Object?> get props => [patients];
}

class PatientListError extends PatientListState {
  final String message;

  PatientListError(this.message);

  @override
  List<Object?> get props => [message];
}