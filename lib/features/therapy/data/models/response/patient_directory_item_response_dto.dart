import 'package:json_annotation/json_annotation.dart';
import '../../../domain/models/patient_directory_item.dart';

part 'patient_directory_item_response_dto.g.dart';

@JsonSerializable()
class PatientDirectoryItemResponseDto {
  final String id;
  final String psychologistId;
  final String patientId;
  final String patientName;
  final int age;
  final String profilePhotoUrl;
  final int status; // El backend devuelve un enum que se serializa como int usualmente, o string dependiendo de la config. Asumiremos int por defecto en C#, si es string cambia esto a String.
  final String startDate;
  final int sessionCount;
  final String? lastSessionDate;

  const PatientDirectoryItemResponseDto({
    required this.id,
    required this.psychologistId,
    required this.patientId,
    required this.patientName,
    required this.age,
    required this.profilePhotoUrl,
    required this.status,
    required this.startDate,
    required this.sessionCount,
    this.lastSessionDate,
  });

  factory PatientDirectoryItemResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDirectoryItemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDirectoryItemResponseDtoToJson(this);

  PatientDirectoryItem toDomain() {
    return PatientDirectoryItem(
      id: id,
      psychologistId: psychologistId,
      patientId: patientId,
      patientName: patientName,
      age: age,
      profilePhotoUrl: profilePhotoUrl,
      // Mapeo simple del estado, puedes mejorarlo con un Enum en el dominio si prefieres
      status: _mapStatusToString(status),
      startDate: DateTime.parse(startDate),
      sessionCount: sessionCount,
      lastSessionDate: lastSessionDate != null ? DateTime.parse(lastSessionDate!) : null,
    );
  }

  String _mapStatusToString(int statusIndex) {
    const statuses = ['Pending', 'Active', 'Paused', 'Terminated'];
    if (statusIndex >= 0 && statusIndex < statuses.length) {
      return statuses[statusIndex];
    }
    return 'Unknown';
  }
}