// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateCheckInRequestImpl _$$CreateCheckInRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateCheckInRequestImpl(
  emotionalLevel: (json['emotionalLevel'] as num).toInt(),
  energyLevel: (json['energyLevel'] as num).toInt(),
  moodDescription: json['moodDescription'] as String,
  sleepHours: (json['sleepHours'] as num).toInt(),
  symptoms: (json['symptoms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$CreateCheckInRequestImplToJson(
  _$CreateCheckInRequestImpl instance,
) => <String, dynamic>{
  'emotionalLevel': instance.emotionalLevel,
  'energyLevel': instance.energyLevel,
  'moodDescription': instance.moodDescription,
  'sleepHours': instance.sleepHours,
  'symptoms': instance.symptoms,
  'notes': instance.notes,
};

_$CheckInModelImpl _$$CheckInModelImplFromJson(Map<String, dynamic> json) =>
    _$CheckInModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      emotionalLevel: (json['emotionalLevel'] as num).toInt(),
      energyLevel: (json['energyLevel'] as num).toInt(),
      moodDescription: json['moodDescription'] as String,
      sleepHours: (json['sleepHours'] as num).toInt(),
      symptoms: (json['symptoms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      notes: json['notes'] as String?,
      completedAt: json['completedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$CheckInModelImplToJson(_$CheckInModelImpl instance) =>
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

_$CreateCheckInApiResponseImpl _$$CreateCheckInApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CreateCheckInApiResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: CheckInModel.fromJson(json['data'] as Map<String, dynamic>),
  timestamp: json['timestamp'] as String,
);

Map<String, dynamic> _$$CreateCheckInApiResponseImplToJson(
  _$CreateCheckInApiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timestamp': instance.timestamp,
};

_$CheckInsHistoryApiResponseImpl _$$CheckInsHistoryApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CheckInsHistoryApiResponseImpl(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>)
      .map((e) => CheckInModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: PaginationModel.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
  timestamp: json['timestamp'] as String,
);

Map<String, dynamic> _$$CheckInsHistoryApiResponseImplToJson(
  _$CheckInsHistoryApiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'pagination': instance.pagination,
  'timestamp': instance.timestamp,
};

_$TodayCheckInApiResponseImpl _$$TodayCheckInApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TodayCheckInApiResponseImpl(
  success: json['success'] as bool,
  data: json['data'] == null
      ? null
      : CheckInModel.fromJson(json['data'] as Map<String, dynamic>),
  hasTodayCheckIn: json['hasTodayCheckIn'] as bool,
  timestamp: json['timestamp'] as String,
);

Map<String, dynamic> _$$TodayCheckInApiResponseImplToJson(
  _$TodayCheckInApiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'hasTodayCheckIn': instance.hasTodayCheckIn,
  'timestamp': instance.timestamp,
};
