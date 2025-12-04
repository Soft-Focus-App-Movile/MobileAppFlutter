import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/crisis_repository.dart';
import 'crisis_event.dart';
import 'crisis_state.dart';

class CrisisBloc extends Bloc<CrisisEvent, CrisisState> {
  final CrisisRepository crisisRepository;

  CrisisBloc({required this.crisisRepository}) : super(CrisisIdleState()) {
    on<SendCrisisAlert>(_onSendCrisisAlert);
    on<ResetCrisisState>(_onResetState);
  }

  Future<void> _onSendCrisisAlert(
    SendCrisisAlert event,
    Emitter<CrisisState> emit,
  ) async {
    emit(CrisisLoadingState());

    try {
      final alert = await crisisRepository.createCrisisAlert(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      emit(CrisisSuccessState(alert));
    } catch (e) {
      emit(CrisisErrorState(e.toString()));
    }
  }

  void _onResetState(
    ResetCrisisState event,
    Emitter<CrisisState> emit,
  ) {
    emit(CrisisIdleState());
  }
}
