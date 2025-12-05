// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_history_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInHistoryResponseDto _$CheckInHistoryResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CheckInHistoryResponseDto(
      checkIns: (json['checkIns'] as List<dynamic>)
          .map((e) => CheckInResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckInHistoryResponseDtoToJson(
        CheckInHistoryResponseDto instance) =>
    <String, dynamic>{
      'checkIns': instance.checkIns,
      'pagination': instance.pagination,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };

CheckInResponseDto _$CheckInResponseDtoFromJson(Map<String, dynamic> json) =>
    CheckInResponseDto(
      id: json['id'] as String,
      userId: json['userId'] as String,
      emotionalLevel: (json['emotionalLevel'] as num).toInt(),
      energyLevel: (json['energyLevel'] as num).toInt(),
      moodDescription: json['moodDescription'] as String,
      sleepHours: (json['sleepHours'] as num).toInt(),
      symptoms:
          (json['symptoms'] as List<dynamic>).map((e) => e as String).toList(),
      notes: json['notes'] as String?,
      completedAt: json['completedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CheckInResponseDtoToJson(CheckInResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'emotionalLevel': instance.emotionalLevel,
      'energyLevel': instance.energyLevel,
      'moodDescription': instance.moodDescription,
      'sleepHours': instance.sleepHours,
      'symptoms': instance.symptoms,
      'notes': instance.notes,
      'completedAt': instance.completedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };