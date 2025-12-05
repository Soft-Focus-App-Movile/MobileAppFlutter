import 'package:json_annotation/json_annotation.dart';
import '../../../../tracking/domain/entities/check_in.dart'; // Importamos la entidad de dominio de Tracking

part 'check_in_history_response_dto.g.dart';

@JsonSerializable()
class CheckInHistoryResponseDto {
  final List<CheckInResponseDto> checkIns;
  final PaginationDto pagination;

  const CheckInHistoryResponseDto({
    required this.checkIns,
    required this.pagination,
  });

  factory CheckInHistoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CheckInHistoryResponseDtoFromJson(json);
}

@JsonSerializable()
class PaginationDto {
  final int currentPage;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginationDto({
    required this.currentPage,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);
}

@JsonSerializable()
class CheckInResponseDto {
  final String id;
  final String userId;
  final int emotionalLevel;
  final int energyLevel;
  final String moodDescription;
  final int sleepHours;
  final List<String> symptoms;
  final String? notes;
  final String completedAt;
  final String createdAt;
  final String updatedAt;

  const CheckInResponseDto({
    required this.id,
    required this.userId,
    required this.emotionalLevel,
    required this.energyLevel,
    required this.moodDescription,
    required this.sleepHours,
    required this.symptoms,
    this.notes,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CheckInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseDtoFromJson(json);

  /// Mapeo al dominio existente en Tracking
  CheckIn toDomain() {
    return CheckIn(
      id: id,
      userId: userId,
      emotionalLevel: emotionalLevel,
      energyLevel: energyLevel,
      moodDescription: moodDescription,
      sleepHours: sleepHours,
      symptoms: symptoms,
      notes: notes,
      completedAt: DateTime.parse(completedAt),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}