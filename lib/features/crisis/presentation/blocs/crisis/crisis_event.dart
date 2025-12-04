abstract class CrisisEvent {}

class SendCrisisAlert extends CrisisEvent {
  final double? latitude;
  final double? longitude;

  SendCrisisAlert({
    this.latitude,
    this.longitude,
  });
}

class ResetCrisisState extends CrisisEvent {}
