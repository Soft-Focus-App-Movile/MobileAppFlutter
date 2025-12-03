import 'package:equatable/equatable.dart';

abstract class AdminUsersEvent extends Equatable {
  const AdminUsersEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends AdminUsersEvent {
  const LoadUsers();
}

class SetFilterUserType extends AdminUsersEvent {
  final String? userType;

  const SetFilterUserType(this.userType);

  @override
  List<Object?> get props => [userType];
}

class SetFilterIsVerified extends AdminUsersEvent {
  final bool? isVerified;

  const SetFilterIsVerified(this.isVerified);

  @override
  List<Object?> get props => [isVerified];
}

class UpdateSearchTerm extends AdminUsersEvent {
  final String searchTerm;

  const UpdateSearchTerm(this.searchTerm);

  @override
  List<Object?> get props => [searchTerm];
}

class SearchUsers extends AdminUsersEvent {
  const SearchUsers();
}

class NextPage extends AdminUsersEvent {
  const NextPage();
}

class PreviousPage extends AdminUsersEvent {
  const PreviousPage();
}

class ClearError extends AdminUsersEvent {
  const ClearError();
}
