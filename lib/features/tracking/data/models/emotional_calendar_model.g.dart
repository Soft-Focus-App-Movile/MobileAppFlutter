// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotional_calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateEmotionalCalendarRequestImpl
_$$CreateEmotionalCalendarRequestImplFromJson(Map<String, dynamic> json) =>
    _$CreateEmotionalCalendarRequestImpl(
      date: json['date'] as String,
      emotionalEmoji: json['emotionalEmoji'] as String,
      moodLevel: (json['moodLevel'] as num).toInt(),
      emotionalTags: (json['emotionalTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CreateEmotionalCalendarRequestImplToJson(
  _$CreateEmotionalCalendarRequestImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'emotionalEmoji': instance.emotionalEmoji,
  'moodLevel': instance.moodLevel,
  'emotionalTags': instance.emotionalTags,
};

_$EmotionalCalendarEntryModelImpl _$$EmotionalCalendarEntryModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmotionalCalendarEntryModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  date: json['date'] as String,
  emotionalEmoji: json['emotionalEmoji'] as String,
  moodLevel: (json['moodLevel'] as num).toInt(),
  emotionalTags: (json['emotionalTags'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$$EmotionalCalendarEntryModelImplToJson(
  _$EmotionalCalendarEntryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'date': instance.date,
  'emotionalEmoji': instance.emotionalEmoji,
  'moodLevel': instance.moodLevel,
  'emotionalTags': instance.emotionalTags,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

_$CreateEmotionalCalendarApiResponseImpl
_$$CreateEmotionalCalendarApiResponseImplFromJson(Map<String, dynamic> json) =>
    _$CreateEmotionalCalendarApiResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: EmotionalCalendarEntryModel.fromJson(
        json['data'] as Map<String, dynamic>,
      ),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$$CreateEmotionalCalendarApiResponseImplToJson(
  _$CreateEmotionalCalendarApiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'timestamp': instance.timestamp,
};

_$DateRangeModelImpl _$$DateRangeModelImplFromJson(Map<String, dynamic> json) =>
    _$DateRangeModelImpl(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$$DateRangeModelImplToJson(
  _$DateRangeModelImpl instance,
) => <String, dynamic>{
  'startDate': instance.startDate,
  'endDate': instance.endDate,
};

_$EmotionalCalendarDataModelImpl _$$EmotionalCalendarDataModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmotionalCalendarDataModelImpl(
  entries: (json['entries'] as List<dynamic>)
      .map(
        (e) => EmotionalCalendarEntryModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  dateRange: DateRangeModel.fromJson(json['dateRange'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$EmotionalCalendarDataModelImplToJson(
  _$EmotionalCalendarDataModelImpl instance,
) => <String, dynamic>{
  'entries': instance.entries,
  'totalCount': instance.totalCount,
  'dateRange': instance.dateRange,
};

_$EmotionalCalendarApiResponseImpl _$$EmotionalCalendarApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$EmotionalCalendarApiResponseImpl(
  success: json['success'] as bool,
  data: EmotionalCalendarDataModel.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
  timestamp: json['timestamp'] as String,
);

Map<String, dynamic> _$$EmotionalCalendarApiResponseImplToJson(
  _$EmotionalCalendarApiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data,
  'timestamp': instance.timestamp,
};
