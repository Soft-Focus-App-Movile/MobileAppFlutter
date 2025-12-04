import '../../../domain/models/crisis_alert.dart';

abstract class CrisisState {}

class CrisisIdleState extends CrisisState {}

class CrisisLoadingState extends CrisisState {}

class CrisisSuccessState extends CrisisState {
  final CrisisAlert alert;

  CrisisSuccessState(this.alert);
}

class CrisisErrorState extends CrisisState {
  final String message;

  CrisisErrorState(this.message);
}
