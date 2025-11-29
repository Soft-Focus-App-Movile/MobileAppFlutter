// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emotional_calendar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateEmotionalCalendarRequest _$CreateEmotionalCalendarRequestFromJson(
  Map<String, dynamic> json,
) {
  return _CreateEmotionalCalendarRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateEmotionalCalendarRequest {
  String get date => throw _privateConstructorUsedError;
  String get emotionalEmoji => throw _privateConstructorUsedError;
  int get moodLevel => throw _privateConstructorUsedError;
  List<String> get emotionalTags => throw _privateConstructorUsedError;

  /// Serializes this CreateEmotionalCalendarRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateEmotionalCalendarRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateEmotionalCalendarRequestCopyWith<CreateEmotionalCalendarRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEmotionalCalendarRequestCopyWith<$Res> {
  factory $CreateEmotionalCalendarRequestCopyWith(
    CreateEmotionalCalendarRequest value,
    $Res Function(CreateEmotionalCalendarRequest) then,
  ) =
      _$CreateEmotionalCalendarRequestCopyWithImpl<
        $Res,
        CreateEmotionalCalendarRequest
      >;
  @useResult
  $Res call({
    String date,
    String emotionalEmoji,
    int moodLevel,
    List<String> emotionalTags,
  });
}

/// @nodoc
class _$CreateEmotionalCalendarRequestCopyWithImpl<
  $Res,
  $Val extends CreateEmotionalCalendarRequest
>
    implements $CreateEmotionalCalendarRequestCopyWith<$Res> {
  _$CreateEmotionalCalendarRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateEmotionalCalendarRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? emotionalEmoji = null,
    Object? moodLevel = null,
    Object? emotionalTags = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            emotionalEmoji: null == emotionalEmoji
                ? _value.emotionalEmoji
                : emotionalEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            moodLevel: null == moodLevel
                ? _value.moodLevel
                : moodLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            emotionalTags: null == emotionalTags
                ? _value.emotionalTags
                : emotionalTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateEmotionalCalendarRequestImplCopyWith<$Res>
    implements $CreateEmotionalCalendarRequestCopyWith<$Res> {
  factory _$$CreateEmotionalCalendarRequestImplCopyWith(
    _$CreateEmotionalCalendarRequestImpl value,
    $Res Function(_$CreateEmotionalCalendarRequestImpl) then,
  ) = __$$CreateEmotionalCalendarRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    String emotionalEmoji,
    int moodLevel,
    List<String> emotionalTags,
  });
}

/// @nodoc
class __$$CreateEmotionalCalendarRequestImplCopyWithImpl<$Res>
    extends
        _$CreateEmotionalCalendarRequestCopyWithImpl<
          $Res,
          _$CreateEmotionalCalendarRequestImpl
        >
    implements _$$CreateEmotionalCalendarRequestImplCopyWith<$Res> {
  __$$CreateEmotionalCalendarRequestImplCopyWithImpl(
    _$CreateEmotionalCalendarRequestImpl _value,
    $Res Function(_$CreateEmotionalCalendarRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateEmotionalCalendarRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? emotionalEmoji = null,
    Object? moodLevel = null,
    Object? emotionalTags = null,
  }) {
    return _then(
      _$CreateEmotionalCalendarRequestImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        emotionalEmoji: null == emotionalEmoji
            ? _value.emotionalEmoji
            : emotionalEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        moodLevel: null == moodLevel
            ? _value.moodLevel
            : moodLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        emotionalTags: null == emotionalTags
            ? _value._emotionalTags
            : emotionalTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateEmotionalCalendarRequestImpl
    implements _CreateEmotionalCalendarRequest {
  const _$CreateEmotionalCalendarRequestImpl({
    required this.date,
    required this.emotionalEmoji,
    required this.moodLevel,
    required final List<String> emotionalTags,
  }) : _emotionalTags = emotionalTags;

  factory _$CreateEmotionalCalendarRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CreateEmotionalCalendarRequestImplFromJson(json);

  @override
  final String date;
  @override
  final String emotionalEmoji;
  @override
  final int moodLevel;
  final List<String> _emotionalTags;
  @override
  List<String> get emotionalTags {
    if (_emotionalTags is EqualUnmodifiableListView) return _emotionalTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emotionalTags);
  }

  @override
  String toString() {
    return 'CreateEmotionalCalendarRequest(date: $date, emotionalEmoji: $emotionalEmoji, moodLevel: $moodLevel, emotionalTags: $emotionalTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEmotionalCalendarRequestImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.emotionalEmoji, emotionalEmoji) ||
                other.emotionalEmoji == emotionalEmoji) &&
            (identical(other.moodLevel, moodLevel) ||
                other.moodLevel == moodLevel) &&
            const DeepCollectionEquality().equals(
              other._emotionalTags,
              _emotionalTags,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    emotionalEmoji,
    moodLevel,
    const DeepCollectionEquality().hash(_emotionalTags),
  );

  /// Create a copy of CreateEmotionalCalendarRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEmotionalCalendarRequestImplCopyWith<
    _$CreateEmotionalCalendarRequestImpl
  >
  get copyWith =>
      __$$CreateEmotionalCalendarRequestImplCopyWithImpl<
        _$CreateEmotionalCalendarRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateEmotionalCalendarRequestImplToJson(this);
  }
}

abstract class _CreateEmotionalCalendarRequest
    implements CreateEmotionalCalendarRequest {
  const factory _CreateEmotionalCalendarRequest({
    required final String date,
    required final String emotionalEmoji,
    required final int moodLevel,
    required final List<String> emotionalTags,
  }) = _$CreateEmotionalCalendarRequestImpl;

  factory _CreateEmotionalCalendarRequest.fromJson(Map<String, dynamic> json) =
      _$CreateEmotionalCalendarRequestImpl.fromJson;

  @override
  String get date;
  @override
  String get emotionalEmoji;
  @override
  int get moodLevel;
  @override
  List<String> get emotionalTags;

  /// Create a copy of CreateEmotionalCalendarRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateEmotionalCalendarRequestImplCopyWith<
    _$CreateEmotionalCalendarRequestImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

EmotionalCalendarEntryModel _$EmotionalCalendarEntryModelFromJson(
  Map<String, dynamic> json,
) {
  return _EmotionalCalendarEntryModel.fromJson(json);
}

/// @nodoc
mixin _$EmotionalCalendarEntryModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get emotionalEmoji => throw _privateConstructorUsedError;
  int get moodLevel => throw _privateConstructorUsedError;
  List<String> get emotionalTags => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EmotionalCalendarEntryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmotionalCalendarEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmotionalCalendarEntryModelCopyWith<EmotionalCalendarEntryModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmotionalCalendarEntryModelCopyWith<$Res> {
  factory $EmotionalCalendarEntryModelCopyWith(
    EmotionalCalendarEntryModel value,
    $Res Function(EmotionalCalendarEntryModel) then,
  ) =
      _$EmotionalCalendarEntryModelCopyWithImpl<
        $Res,
        EmotionalCalendarEntryModel
      >;
  @useResult
  $Res call({
    String id,
    String userId,
    String date,
    String emotionalEmoji,
    int moodLevel,
    List<String> emotionalTags,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class _$EmotionalCalendarEntryModelCopyWithImpl<
  $Res,
  $Val extends EmotionalCalendarEntryModel
>
    implements $EmotionalCalendarEntryModelCopyWith<$Res> {
  _$EmotionalCalendarEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmotionalCalendarEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? emotionalEmoji = null,
    Object? moodLevel = null,
    Object? emotionalTags = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            emotionalEmoji: null == emotionalEmoji
                ? _value.emotionalEmoji
                : emotionalEmoji // ignore: cast_nullable_to_non_nullable
                      as String,
            moodLevel: null == moodLevel
                ? _value.moodLevel
                : moodLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            emotionalTags: null == emotionalTags
                ? _value.emotionalTags
                : emotionalTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmotionalCalendarEntryModelImplCopyWith<$Res>
    implements $EmotionalCalendarEntryModelCopyWith<$Res> {
  factory _$$EmotionalCalendarEntryModelImplCopyWith(
    _$EmotionalCalendarEntryModelImpl value,
    $Res Function(_$EmotionalCalendarEntryModelImpl) then,
  ) = __$$EmotionalCalendarEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String date,
    String emotionalEmoji,
    int moodLevel,
    List<String> emotionalTags,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class __$$EmotionalCalendarEntryModelImplCopyWithImpl<$Res>
    extends
        _$EmotionalCalendarEntryModelCopyWithImpl<
          $Res,
          _$EmotionalCalendarEntryModelImpl
        >
    implements _$$EmotionalCalendarEntryModelImplCopyWith<$Res> {
  __$$EmotionalCalendarEntryModelImplCopyWithImpl(
    _$EmotionalCalendarEntryModelImpl _value,
    $Res Function(_$EmotionalCalendarEntryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmotionalCalendarEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? date = null,
    Object? emotionalEmoji = null,
    Object? moodLevel = null,
    Object? emotionalTags = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$EmotionalCalendarEntryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        emotionalEmoji: null == emotionalEmoji
            ? _value.emotionalEmoji
            : emotionalEmoji // ignore: cast_nullable_to_non_nullable
                  as String,
        moodLevel: null == moodLevel
            ? _value.moodLevel
            : moodLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        emotionalTags: null == emotionalTags
            ? _value._emotionalTags
            : emotionalTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmotionalCalendarEntryModelImpl
    implements _EmotionalCalendarEntryModel {
  const _$EmotionalCalendarEntryModelImpl({
    required this.id,
    required this.userId,
    required this.date,
    required this.emotionalEmoji,
    required this.moodLevel,
    required final List<String> emotionalTags,
    required this.createdAt,
    required this.updatedAt,
  }) : _emotionalTags = emotionalTags;

  factory _$EmotionalCalendarEntryModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EmotionalCalendarEntryModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String date;
  @override
  final String emotionalEmoji;
  @override
  final int moodLevel;
  final List<String> _emotionalTags;
  @override
  List<String> get emotionalTags {
    if (_emotionalTags is EqualUnmodifiableListView) return _emotionalTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emotionalTags);
  }

  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'EmotionalCalendarEntryModel(id: $id, userId: $userId, date: $date, emotionalEmoji: $emotionalEmoji, moodLevel: $moodLevel, emotionalTags: $emotionalTags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmotionalCalendarEntryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.emotionalEmoji, emotionalEmoji) ||
                other.emotionalEmoji == emotionalEmoji) &&
            (identical(other.moodLevel, moodLevel) ||
                other.moodLevel == moodLevel) &&
            const DeepCollectionEquality().equals(
              other._emotionalTags,
              _emotionalTags,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    date,
    emotionalEmoji,
    moodLevel,
    const DeepCollectionEquality().hash(_emotionalTags),
    createdAt,
    updatedAt,
  );

  /// Create a copy of EmotionalCalendarEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmotionalCalendarEntryModelImplCopyWith<_$EmotionalCalendarEntryModelImpl>
  get copyWith =>
      __$$EmotionalCalendarEntryModelImplCopyWithImpl<
        _$EmotionalCalendarEntryModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmotionalCalendarEntryModelImplToJson(this);
  }
}

abstract class _EmotionalCalendarEntryModel
    implements EmotionalCalendarEntryModel {
  const factory _EmotionalCalendarEntryModel({
    required final String id,
    required final String userId,
    required final String date,
    required final String emotionalEmoji,
    required final int moodLevel,
    required final List<String> emotionalTags,
    required final String createdAt,
    required final String updatedAt,
  }) = _$EmotionalCalendarEntryModelImpl;

  factory _EmotionalCalendarEntryModel.fromJson(Map<String, dynamic> json) =
      _$EmotionalCalendarEntryModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get date;
  @override
  String get emotionalEmoji;
  @override
  int get moodLevel;
  @override
  List<String> get emotionalTags;
  @override
  String get createdAt;
  @override
  String get updatedAt;

  /// Create a copy of EmotionalCalendarEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmotionalCalendarEntryModelImplCopyWith<_$EmotionalCalendarEntryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CreateEmotionalCalendarApiResponse _$CreateEmotionalCalendarApiResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CreateEmotionalCalendarApiResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateEmotionalCalendarApiResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  EmotionalCalendarEntryModel get data => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this CreateEmotionalCalendarApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateEmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateEmotionalCalendarApiResponseCopyWith<
    CreateEmotionalCalendarApiResponse
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEmotionalCalendarApiResponseCopyWith<$Res> {
  factory $CreateEmotionalCalendarApiResponseCopyWith(
    CreateEmotionalCalendarApiResponse value,
    $Res Function(CreateEmotionalCalendarApiResponse) then,
  ) =
      _$CreateEmotionalCalendarApiResponseCopyWithImpl<
        $Res,
        CreateEmotionalCalendarApiResponse
      >;
  @useResult
  $Res call({
    bool success,
    String message,
    EmotionalCalendarEntryModel data,
    String timestamp,
  });

  $EmotionalCalendarEntryModelCopyWith<$Res> get data;
}

/// @nodoc
class _$CreateEmotionalCalendarApiResponseCopyWithImpl<
  $Res,
  $Val extends CreateEmotionalCalendarApiResponse
>
    implements $CreateEmotionalCalendarApiResponseCopyWith<$Res> {
  _$CreateEmotionalCalendarApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateEmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as EmotionalCalendarEntryModel,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of CreateEmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmotionalCalendarEntryModelCopyWith<$Res> get data {
    return $EmotionalCalendarEntryModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateEmotionalCalendarApiResponseImplCopyWith<$Res>
    implements $CreateEmotionalCalendarApiResponseCopyWith<$Res> {
  factory _$$CreateEmotionalCalendarApiResponseImplCopyWith(
    _$CreateEmotionalCalendarApiResponseImpl value,
    $Res Function(_$CreateEmotionalCalendarApiResponseImpl) then,
  ) = __$$CreateEmotionalCalendarApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String message,
    EmotionalCalendarEntryModel data,
    String timestamp,
  });

  @override
  $EmotionalCalendarEntryModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$CreateEmotionalCalendarApiResponseImplCopyWithImpl<$Res>
    extends
        _$CreateEmotionalCalendarApiResponseCopyWithImpl<
          $Res,
          _$CreateEmotionalCalendarApiResponseImpl
        >
    implements _$$CreateEmotionalCalendarApiResponseImplCopyWith<$Res> {
  __$$CreateEmotionalCalendarApiResponseImplCopyWithImpl(
    _$CreateEmotionalCalendarApiResponseImpl _value,
    $Res Function(_$CreateEmotionalCalendarApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateEmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$CreateEmotionalCalendarApiResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as EmotionalCalendarEntryModel,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateEmotionalCalendarApiResponseImpl
    implements _CreateEmotionalCalendarApiResponse {
  const _$CreateEmotionalCalendarApiResponseImpl({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory _$CreateEmotionalCalendarApiResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CreateEmotionalCalendarApiResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final EmotionalCalendarEntryModel data;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'CreateEmotionalCalendarApiResponse(success: $success, message: $message, data: $data, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEmotionalCalendarApiResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, data, timestamp);

  /// Create a copy of CreateEmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEmotionalCalendarApiResponseImplCopyWith<
    _$CreateEmotionalCalendarApiResponseImpl
  >
  get copyWith =>
      __$$CreateEmotionalCalendarApiResponseImplCopyWithImpl<
        _$CreateEmotionalCalendarApiResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateEmotionalCalendarApiResponseImplToJson(this);
  }
}

abstract class _CreateEmotionalCalendarApiResponse
    implements CreateEmotionalCalendarApiResponse {
  const factory _CreateEmotionalCalendarApiResponse({
    required final bool success,
    required final String message,
    required final EmotionalCalendarEntryModel data,
    required final String timestamp,
  }) = _$CreateEmotionalCalendarApiResponseImpl;

  factory _CreateEmotionalCalendarApiResponse.fromJson(
    Map<String, dynamic> json,
  ) = _$CreateEmotionalCalendarApiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  EmotionalCalendarEntryModel get data;
  @override
  String get timestamp;

  /// Create a copy of CreateEmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateEmotionalCalendarApiResponseImplCopyWith<
    _$CreateEmotionalCalendarApiResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DateRangeModel _$DateRangeModelFromJson(Map<String, dynamic> json) {
  return _DateRangeModel.fromJson(json);
}

/// @nodoc
mixin _$DateRangeModel {
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;

  /// Serializes this DateRangeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateRangeModelCopyWith<DateRangeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateRangeModelCopyWith<$Res> {
  factory $DateRangeModelCopyWith(
    DateRangeModel value,
    $Res Function(DateRangeModel) then,
  ) = _$DateRangeModelCopyWithImpl<$Res, DateRangeModel>;
  @useResult
  $Res call({String? startDate, String? endDate});
}

/// @nodoc
class _$DateRangeModelCopyWithImpl<$Res, $Val extends DateRangeModel>
    implements $DateRangeModelCopyWith<$Res> {
  _$DateRangeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _value.copyWith(
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DateRangeModelImplCopyWith<$Res>
    implements $DateRangeModelCopyWith<$Res> {
  factory _$$DateRangeModelImplCopyWith(
    _$DateRangeModelImpl value,
    $Res Function(_$DateRangeModelImpl) then,
  ) = __$$DateRangeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? startDate, String? endDate});
}

/// @nodoc
class __$$DateRangeModelImplCopyWithImpl<$Res>
    extends _$DateRangeModelCopyWithImpl<$Res, _$DateRangeModelImpl>
    implements _$$DateRangeModelImplCopyWith<$Res> {
  __$$DateRangeModelImplCopyWithImpl(
    _$DateRangeModelImpl _value,
    $Res Function(_$DateRangeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DateRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$DateRangeModelImpl(
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DateRangeModelImpl implements _DateRangeModel {
  const _$DateRangeModelImpl({this.startDate, this.endDate});

  factory _$DateRangeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateRangeModelImplFromJson(json);

  @override
  final String? startDate;
  @override
  final String? endDate;

  @override
  String toString() {
    return 'DateRangeModel(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateRangeModelImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of DateRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateRangeModelImplCopyWith<_$DateRangeModelImpl> get copyWith =>
      __$$DateRangeModelImplCopyWithImpl<_$DateRangeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DateRangeModelImplToJson(this);
  }
}

abstract class _DateRangeModel implements DateRangeModel {
  const factory _DateRangeModel({
    final String? startDate,
    final String? endDate,
  }) = _$DateRangeModelImpl;

  factory _DateRangeModel.fromJson(Map<String, dynamic> json) =
      _$DateRangeModelImpl.fromJson;

  @override
  String? get startDate;
  @override
  String? get endDate;

  /// Create a copy of DateRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateRangeModelImplCopyWith<_$DateRangeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmotionalCalendarDataModel _$EmotionalCalendarDataModelFromJson(
  Map<String, dynamic> json,
) {
  return _EmotionalCalendarDataModel.fromJson(json);
}

/// @nodoc
mixin _$EmotionalCalendarDataModel {
  List<EmotionalCalendarEntryModel> get entries =>
      throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  DateRangeModel get dateRange => throw _privateConstructorUsedError;

  /// Serializes this EmotionalCalendarDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmotionalCalendarDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmotionalCalendarDataModelCopyWith<EmotionalCalendarDataModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmotionalCalendarDataModelCopyWith<$Res> {
  factory $EmotionalCalendarDataModelCopyWith(
    EmotionalCalendarDataModel value,
    $Res Function(EmotionalCalendarDataModel) then,
  ) =
      _$EmotionalCalendarDataModelCopyWithImpl<
        $Res,
        EmotionalCalendarDataModel
      >;
  @useResult
  $Res call({
    List<EmotionalCalendarEntryModel> entries,
    int totalCount,
    DateRangeModel dateRange,
  });

  $DateRangeModelCopyWith<$Res> get dateRange;
}

/// @nodoc
class _$EmotionalCalendarDataModelCopyWithImpl<
  $Res,
  $Val extends EmotionalCalendarDataModel
>
    implements $EmotionalCalendarDataModelCopyWith<$Res> {
  _$EmotionalCalendarDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmotionalCalendarDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? totalCount = null,
    Object? dateRange = null,
  }) {
    return _then(
      _value.copyWith(
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<EmotionalCalendarEntryModel>,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            dateRange: null == dateRange
                ? _value.dateRange
                : dateRange // ignore: cast_nullable_to_non_nullable
                      as DateRangeModel,
          )
          as $Val,
    );
  }

  /// Create a copy of EmotionalCalendarDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DateRangeModelCopyWith<$Res> get dateRange {
    return $DateRangeModelCopyWith<$Res>(_value.dateRange, (value) {
      return _then(_value.copyWith(dateRange: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmotionalCalendarDataModelImplCopyWith<$Res>
    implements $EmotionalCalendarDataModelCopyWith<$Res> {
  factory _$$EmotionalCalendarDataModelImplCopyWith(
    _$EmotionalCalendarDataModelImpl value,
    $Res Function(_$EmotionalCalendarDataModelImpl) then,
  ) = __$$EmotionalCalendarDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<EmotionalCalendarEntryModel> entries,
    int totalCount,
    DateRangeModel dateRange,
  });

  @override
  $DateRangeModelCopyWith<$Res> get dateRange;
}

/// @nodoc
class __$$EmotionalCalendarDataModelImplCopyWithImpl<$Res>
    extends
        _$EmotionalCalendarDataModelCopyWithImpl<
          $Res,
          _$EmotionalCalendarDataModelImpl
        >
    implements _$$EmotionalCalendarDataModelImplCopyWith<$Res> {
  __$$EmotionalCalendarDataModelImplCopyWithImpl(
    _$EmotionalCalendarDataModelImpl _value,
    $Res Function(_$EmotionalCalendarDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmotionalCalendarDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? totalCount = null,
    Object? dateRange = null,
  }) {
    return _then(
      _$EmotionalCalendarDataModelImpl(
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<EmotionalCalendarEntryModel>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        dateRange: null == dateRange
            ? _value.dateRange
            : dateRange // ignore: cast_nullable_to_non_nullable
                  as DateRangeModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmotionalCalendarDataModelImpl implements _EmotionalCalendarDataModel {
  const _$EmotionalCalendarDataModelImpl({
    required final List<EmotionalCalendarEntryModel> entries,
    required this.totalCount,
    required this.dateRange,
  }) : _entries = entries;

  factory _$EmotionalCalendarDataModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EmotionalCalendarDataModelImplFromJson(json);

  final List<EmotionalCalendarEntryModel> _entries;
  @override
  List<EmotionalCalendarEntryModel> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final int totalCount;
  @override
  final DateRangeModel dateRange;

  @override
  String toString() {
    return 'EmotionalCalendarDataModel(entries: $entries, totalCount: $totalCount, dateRange: $dateRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmotionalCalendarDataModelImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_entries),
    totalCount,
    dateRange,
  );

  /// Create a copy of EmotionalCalendarDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmotionalCalendarDataModelImplCopyWith<_$EmotionalCalendarDataModelImpl>
  get copyWith =>
      __$$EmotionalCalendarDataModelImplCopyWithImpl<
        _$EmotionalCalendarDataModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmotionalCalendarDataModelImplToJson(this);
  }
}

abstract class _EmotionalCalendarDataModel
    implements EmotionalCalendarDataModel {
  const factory _EmotionalCalendarDataModel({
    required final List<EmotionalCalendarEntryModel> entries,
    required final int totalCount,
    required final DateRangeModel dateRange,
  }) = _$EmotionalCalendarDataModelImpl;

  factory _EmotionalCalendarDataModel.fromJson(Map<String, dynamic> json) =
      _$EmotionalCalendarDataModelImpl.fromJson;

  @override
  List<EmotionalCalendarEntryModel> get entries;
  @override
  int get totalCount;
  @override
  DateRangeModel get dateRange;

  /// Create a copy of EmotionalCalendarDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmotionalCalendarDataModelImplCopyWith<_$EmotionalCalendarDataModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EmotionalCalendarApiResponse _$EmotionalCalendarApiResponseFromJson(
  Map<String, dynamic> json,
) {
  return _EmotionalCalendarApiResponse.fromJson(json);
}

/// @nodoc
mixin _$EmotionalCalendarApiResponse {
  bool get success => throw _privateConstructorUsedError;
  EmotionalCalendarDataModel get data => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this EmotionalCalendarApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmotionalCalendarApiResponseCopyWith<EmotionalCalendarApiResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmotionalCalendarApiResponseCopyWith<$Res> {
  factory $EmotionalCalendarApiResponseCopyWith(
    EmotionalCalendarApiResponse value,
    $Res Function(EmotionalCalendarApiResponse) then,
  ) =
      _$EmotionalCalendarApiResponseCopyWithImpl<
        $Res,
        EmotionalCalendarApiResponse
      >;
  @useResult
  $Res call({bool success, EmotionalCalendarDataModel data, String timestamp});

  $EmotionalCalendarDataModelCopyWith<$Res> get data;
}

/// @nodoc
class _$EmotionalCalendarApiResponseCopyWithImpl<
  $Res,
  $Val extends EmotionalCalendarApiResponse
>
    implements $EmotionalCalendarApiResponseCopyWith<$Res> {
  _$EmotionalCalendarApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as EmotionalCalendarDataModel,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of EmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmotionalCalendarDataModelCopyWith<$Res> get data {
    return $EmotionalCalendarDataModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmotionalCalendarApiResponseImplCopyWith<$Res>
    implements $EmotionalCalendarApiResponseCopyWith<$Res> {
  factory _$$EmotionalCalendarApiResponseImplCopyWith(
    _$EmotionalCalendarApiResponseImpl value,
    $Res Function(_$EmotionalCalendarApiResponseImpl) then,
  ) = __$$EmotionalCalendarApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, EmotionalCalendarDataModel data, String timestamp});

  @override
  $EmotionalCalendarDataModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$EmotionalCalendarApiResponseImplCopyWithImpl<$Res>
    extends
        _$EmotionalCalendarApiResponseCopyWithImpl<
          $Res,
          _$EmotionalCalendarApiResponseImpl
        >
    implements _$$EmotionalCalendarApiResponseImplCopyWith<$Res> {
  __$$EmotionalCalendarApiResponseImplCopyWithImpl(
    _$EmotionalCalendarApiResponseImpl _value,
    $Res Function(_$EmotionalCalendarApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$EmotionalCalendarApiResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as EmotionalCalendarDataModel,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmotionalCalendarApiResponseImpl
    implements _EmotionalCalendarApiResponse {
  const _$EmotionalCalendarApiResponseImpl({
    required this.success,
    required this.data,
    required this.timestamp,
  });

  factory _$EmotionalCalendarApiResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$EmotionalCalendarApiResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final EmotionalCalendarDataModel data;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'EmotionalCalendarApiResponse(success: $success, data: $data, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmotionalCalendarApiResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, timestamp);

  /// Create a copy of EmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmotionalCalendarApiResponseImplCopyWith<
    _$EmotionalCalendarApiResponseImpl
  >
  get copyWith =>
      __$$EmotionalCalendarApiResponseImplCopyWithImpl<
        _$EmotionalCalendarApiResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmotionalCalendarApiResponseImplToJson(this);
  }
}

abstract class _EmotionalCalendarApiResponse
    implements EmotionalCalendarApiResponse {
  const factory _EmotionalCalendarApiResponse({
    required final bool success,
    required final EmotionalCalendarDataModel data,
    required final String timestamp,
  }) = _$EmotionalCalendarApiResponseImpl;

  factory _EmotionalCalendarApiResponse.fromJson(Map<String, dynamic> json) =
      _$EmotionalCalendarApiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  EmotionalCalendarDataModel get data;
  @override
  String get timestamp;

  /// Create a copy of EmotionalCalendarApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmotionalCalendarApiResponseImplCopyWith<
    _$EmotionalCalendarApiResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
