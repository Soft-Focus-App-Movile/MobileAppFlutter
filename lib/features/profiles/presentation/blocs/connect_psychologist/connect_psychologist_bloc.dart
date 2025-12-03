import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../therapy/domain/repositories/therapy_repository.dart';
import '../../../../../core/common/result.dart';
import 'connect_psychologist_event.dart';
import 'connect_psychologist_state.dart';

class ConnectPsychologistBloc extends Bloc<ConnectPsychologistEvent, ConnectPsychologistState> {
  final TherapyRepository therapyRepository;

  ConnectPsychologistBloc({
    required this.therapyRepository,
  }) : super(const ConnectPsychologistInitial()) {
    on<ConnectWithCodeRequested>(_onConnectWithCodeRequested);
    on<ResetConnectionState>(_onResetConnectionState);
  }

  Future<void> _onConnectWithCodeRequested(
    ConnectWithCodeRequested event,
    Emitter<ConnectPsychologistState> emit,
  ) async {
    emit(const ConnectPsychologistLoading());

    final result = await therapyRepository.connectWithPsychologist(event.connectionCode);

    switch (result) {
      case Success(:final data):
        emit(ConnectPsychologistSuccess(data));
        break;
      case Error(:final message):
        emit(ConnectPsychologistError(message));
        break;
    }
  }

  Future<void> _onResetConnectionState(
    ResetConnectionState event,
    Emitter<ConnectPsychologistState> emit,
  ) async {
    emit(const ConnectPsychologistInitial());
  }
}
