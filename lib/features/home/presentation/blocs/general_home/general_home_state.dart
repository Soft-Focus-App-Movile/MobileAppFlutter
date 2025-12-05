import '../../../../library/domain/models/content.dart';

abstract class GeneralHomeState {}

class GeneralHomeInitial extends GeneralHomeState {}

class GeneralHomeLoading extends GeneralHomeState {}

class GeneralHomeSuccess extends GeneralHomeState {
  final List<Content> recommendations;

  GeneralHomeSuccess(this.recommendations);
}

class GeneralHomeEmpty extends GeneralHomeState {}

class GeneralHomeError extends GeneralHomeState {
  final String message;

  GeneralHomeError(this.message);
}
