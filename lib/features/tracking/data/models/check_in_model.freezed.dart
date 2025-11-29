// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateCheckInRequest _$CreateCheckInRequestFromJson(Map<String, dynamic> json) {
  return _CreateCheckInRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateCheckInRequest {
  int get emotionalLevel => throw _privateConstructorUsedError;
  int get energyLevel => throw _privateConstructorUsedError;
  String get moodDescription => throw _privateConstructorUsedError;
  int get sleepHours => throw _privateConstructorUsedError;
  List<String> get symptoms => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this CreateCheckInRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCheckInRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCheckInRequestCopyWith<CreateCheckInRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCheckInRequestCopyWith<$Res> {
  factory $CreateCheckInRequestCopyWith(
    CreateCheckInRequest value,
    $Res Function(CreateCheckInRequest) then,
  ) = _$CreateCheckInRequestCopyWithImpl<$Res, CreateCheckInRequest>;
  @useResult
  $Res call({
    int emotionalLevel,
    int energyLevel,
    String moodDescription,
    int sleepHours,
    List<String> symptoms,
    String? notes,
  });
}

/// @nodoc
class _$CreateCheckInRequestCopyWithImpl<
  $Res,
  $Val extends CreateCheckInRequest
>
    implements $CreateCheckInRequestCopyWith<$Res> {
  _$CreateCheckInRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCheckInRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emotionalLevel = null,
    Object? energyLevel = null,
    Object? moodDescription = null,
    Object? sleepHours = null,
    Object? symptoms = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            emotionalLevel: null == emotionalLevel
                ? _value.emotionalLevel
                : emotionalLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            energyLevel: null == energyLevel
                ? _value.energyLevel
                : energyLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            moodDescription: null == moodDescription
                ? _value.moodDescription
                : moodDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            sleepHours: null == sleepHours
                ? _value.sleepHours
                : sleepHours // ignore: cast_nullable_to_non_nullable
                      as int,
            symptoms: null == symptoms
                ? _value.symptoms
                : symptoms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateCheckInRequestImplCopyWith<$Res>
    implements $CreateCheckInRequestCopyWith<$Res> {
  factory _$$CreateCheckInRequestImplCopyWith(
    _$CreateCheckInRequestImpl value,
    $Res Function(_$CreateCheckInRequestImpl) then,
  ) = __$$CreateCheckInRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int emotionalLevel,
    int energyLevel,
    String moodDescription,
    int sleepHours,
    List<String> symptoms,
    String? notes,
  });
}

/// @nodoc
class __$$CreateCheckInRequestImplCopyWithImpl<$Res>
    extends _$CreateCheckInRequestCopyWithImpl<$Res, _$CreateCheckInRequestImpl>
    implements _$$CreateCheckInRequestImplCopyWith<$Res> {
  __$$CreateCheckInRequestImplCopyWithImpl(
    _$CreateCheckInRequestImpl _value,
    $Res Function(_$CreateCheckInRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateCheckInRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emotionalLevel = null,
    Object? energyLevel = null,
    Object? moodDescription = null,
    Object? sleepHours = null,
    Object? symptoms = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$CreateCheckInRequestImpl(
        emotionalLevel: null == emotionalLevel
            ? _value.emotionalLevel
            : emotionalLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        energyLevel: null == energyLevel
            ? _value.energyLevel
            : energyLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        moodDescription: null == moodDescription
            ? _value.moodDescription
            : moodDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        sleepHours: null == sleepHours
            ? _value.sleepHours
            : sleepHours // ignore: cast_nullable_to_non_nullable
                  as int,
        symptoms: null == symptoms
            ? _value._symptoms
            : symptoms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCheckInRequestImpl implements _CreateCheckInRequest {
  const _$CreateCheckInRequestImpl({
    required this.emotionalLevel,
    required this.energyLevel,
    required this.moodDescription,
    required this.sleepHours,
    required final List<String> symptoms,
    this.notes,
  }) : _symptoms = symptoms;

  factory _$CreateCheckInRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCheckInRequestImplFromJson(json);

  @override
  final int emotionalLevel;
  @override
  final int energyLevel;
  @override
  final String moodDescription;
  @override
  final int sleepHours;
  final List<String> _symptoms;
  @override
  List<String> get symptoms {
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptoms);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'CreateCheckInRequest(emotionalLevel: $emotionalLevel, energyLevel: $energyLevel, moodDescription: $moodDescription, sleepHours: $sleepHours, symptoms: $symptoms, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCheckInRequestImpl &&
            (identical(other.emotionalLevel, emotionalLevel) ||
                other.emotionalLevel == emotionalLevel) &&
            (identical(other.energyLevel, energyLevel) ||
                other.energyLevel == energyLevel) &&
            (identical(other.moodDescription, moodDescription) ||
                other.moodDescription == moodDescription) &&
            (identical(other.sleepHours, sleepHours) ||
                other.sleepHours == sleepHours) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    emotionalLevel,
    energyLevel,
    moodDescription,
    sleepHours,
    const DeepCollectionEquality().hash(_symptoms),
    notes,
  );

  /// Create a copy of CreateCheckInRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCheckInRequestImplCopyWith<_$CreateCheckInRequestImpl>
  get copyWith =>
      __$$CreateCheckInRequestImplCopyWithImpl<_$CreateCheckInRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCheckInRequestImplToJson(this);
  }
}

abstract class _CreateCheckInRequest implements CreateCheckInRequest {
  const factory _CreateCheckInRequest({
    required final int emotionalLevel,
    required final int energyLevel,
    required final String moodDescription,
    required final int sleepHours,
    required final List<String> symptoms,
    final String? notes,
  }) = _$CreateCheckInRequestImpl;

  factory _CreateCheckInRequest.fromJson(Map<String, dynamic> json) =
      _$CreateCheckInRequestImpl.fromJson;

  @override
  int get emotionalLevel;
  @override
  int get energyLevel;
  @override
  String get moodDescription;
  @override
  int get sleepHours;
  @override
  List<String> get symptoms;
  @override
  String? get notes;

  /// Create a copy of CreateCheckInRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCheckInRequestImplCopyWith<_$CreateCheckInRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CheckInModel _$CheckInModelFromJson(Map<String, dynamic> json) {
  return _CheckInModel.fromJson(json);
}

/// @nodoc
mixin _$CheckInModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get emotionalLevel => throw _privateConstructorUsedError;
  int get energyLevel => throw _privateConstructorUsedError;
  String get moodDescription => throw _privateConstructorUsedError;
  int get sleepHours => throw _privateConstructorUsedError;
  List<String> get symptoms => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get completedAt => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CheckInModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInModelCopyWith<CheckInModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInModelCopyWith<$Res> {
  factory $CheckInModelCopyWith(
    CheckInModel value,
    $Res Function(CheckInModel) then,
  ) = _$CheckInModelCopyWithImpl<$Res, CheckInModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    int emotionalLevel,
    int energyLevel,
    String moodDescription,
    int sleepHours,
    List<String> symptoms,
    String? notes,
    String completedAt,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class _$CheckInModelCopyWithImpl<$Res, $Val extends CheckInModel>
    implements $CheckInModelCopyWith<$Res> {
  _$CheckInModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? emotionalLevel = null,
    Object? energyLevel = null,
    Object? moodDescription = null,
    Object? sleepHours = null,
    Object? symptoms = null,
    Object? notes = freezed,
    Object? completedAt = null,
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
            emotionalLevel: null == emotionalLevel
                ? _value.emotionalLevel
                : emotionalLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            energyLevel: null == energyLevel
                ? _value.energyLevel
                : energyLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            moodDescription: null == moodDescription
                ? _value.moodDescription
                : moodDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            sleepHours: null == sleepHours
                ? _value.sleepHours
                : sleepHours // ignore: cast_nullable_to_non_nullable
                      as int,
            symptoms: null == symptoms
                ? _value.symptoms
                : symptoms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            completedAt: null == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$CheckInModelImplCopyWith<$Res>
    implements $CheckInModelCopyWith<$Res> {
  factory _$$CheckInModelImplCopyWith(
    _$CheckInModelImpl value,
    $Res Function(_$CheckInModelImpl) then,
  ) = __$$CheckInModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    int emotionalLevel,
    int energyLevel,
    String moodDescription,
    int sleepHours,
    List<String> symptoms,
    String? notes,
    String completedAt,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class __$$CheckInModelImplCopyWithImpl<$Res>
    extends _$CheckInModelCopyWithImpl<$Res, _$CheckInModelImpl>
    implements _$$CheckInModelImplCopyWith<$Res> {
  __$$CheckInModelImplCopyWithImpl(
    _$CheckInModelImpl _value,
    $Res Function(_$CheckInModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? emotionalLevel = null,
    Object? energyLevel = null,
    Object? moodDescription = null,
    Object? sleepHours = null,
    Object? symptoms = null,
    Object? notes = freezed,
    Object? completedAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CheckInModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        emotionalLevel: null == emotionalLevel
            ? _value.emotionalLevel
            : emotionalLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        energyLevel: null == energyLevel
            ? _value.energyLevel
            : energyLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        moodDescription: null == moodDescription
            ? _value.moodDescription
            : moodDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        sleepHours: null == sleepHours
            ? _value.sleepHours
            : sleepHours // ignore: cast_nullable_to_non_nullable
                  as int,
        symptoms: null == symptoms
            ? _value._symptoms
            : symptoms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$CheckInModelImpl implements _CheckInModel {
  const _$CheckInModelImpl({
    required this.id,
    required this.userId,
    required this.emotionalLevel,
    required this.energyLevel,
    required this.moodDescription,
    required this.sleepHours,
    required final List<String> symptoms,
    this.notes,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  }) : _symptoms = symptoms;

  factory _$CheckInModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckInModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final int emotionalLevel;
  @override
  final int energyLevel;
  @override
  final String moodDescription;
  @override
  final int sleepHours;
  final List<String> _symptoms;
  @override
  List<String> get symptoms {
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_symptoms);
  }

  @override
  final String? notes;
  @override
  final String completedAt;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'CheckInModel(id: $id, userId: $userId, emotionalLevel: $emotionalLevel, energyLevel: $energyLevel, moodDescription: $moodDescription, sleepHours: $sleepHours, symptoms: $symptoms, notes: $notes, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.emotionalLevel, emotionalLevel) ||
                other.emotionalLevel == emotionalLevel) &&
            (identical(other.energyLevel, energyLevel) ||
                other.energyLevel == energyLevel) &&
            (identical(other.moodDescription, moodDescription) ||
                other.moodDescription == moodDescription) &&
            (identical(other.sleepHours, sleepHours) ||
                other.sleepHours == sleepHours) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
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
    emotionalLevel,
    energyLevel,
    moodDescription,
    sleepHours,
    const DeepCollectionEquality().hash(_symptoms),
    notes,
    completedAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of CheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInModelImplCopyWith<_$CheckInModelImpl> get copyWith =>
      __$$CheckInModelImplCopyWithImpl<_$CheckInModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckInModelImplToJson(this);
  }
}

abstract class _CheckInModel implements CheckInModel {
  const factory _CheckInModel({
    required final String id,
    required final String userId,
    required final int emotionalLevel,
    required final int energyLevel,
    required final String moodDescription,
    required final int sleepHours,
    required final List<String> symptoms,
    final String? notes,
    required final String completedAt,
    required final String createdAt,
    required final String updatedAt,
  }) = _$CheckInModelImpl;

  factory _CheckInModel.fromJson(Map<String, dynamic> json) =
      _$CheckInModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  int get emotionalLevel;
  @override
  int get energyLevel;
  @override
  String get moodDescription;
  @override
  int get sleepHours;
  @override
  List<String> get symptoms;
  @override
  String? get notes;
  @override
  String get completedAt;
  @override
  String get createdAt;
  @override
  String get updatedAt;

  /// Create a copy of CheckInModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInModelImplCopyWith<_$CheckInModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateCheckInApiResponse _$CreateCheckInApiResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CreateCheckInApiResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateCheckInApiResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CheckInModel get data => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this CreateCheckInApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCheckInApiResponseCopyWith<CreateCheckInApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCheckInApiResponseCopyWith<$Res> {
  factory $CreateCheckInApiResponseCopyWith(
    CreateCheckInApiResponse value,
    $Res Function(CreateCheckInApiResponse) then,
  ) = _$CreateCheckInApiResponseCopyWithImpl<$Res, CreateCheckInApiResponse>;
  @useResult
  $Res call({
    bool success,
    String message,
    CheckInModel data,
    String timestamp,
  });

  $CheckInModelCopyWith<$Res> get data;
}

/// @nodoc
class _$CreateCheckInApiResponseCopyWithImpl<
  $Res,
  $Val extends CreateCheckInApiResponse
>
    implements $CreateCheckInApiResponseCopyWith<$Res> {
  _$CreateCheckInApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCheckInApiResponse
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
                      as CheckInModel,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of CreateCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckInModelCopyWith<$Res> get data {
    return $CheckInModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateCheckInApiResponseImplCopyWith<$Res>
    implements $CreateCheckInApiResponseCopyWith<$Res> {
  factory _$$CreateCheckInApiResponseImplCopyWith(
    _$CreateCheckInApiResponseImpl value,
    $Res Function(_$CreateCheckInApiResponseImpl) then,
  ) = __$$CreateCheckInApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String message,
    CheckInModel data,
    String timestamp,
  });

  @override
  $CheckInModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$CreateCheckInApiResponseImplCopyWithImpl<$Res>
    extends
        _$CreateCheckInApiResponseCopyWithImpl<
          $Res,
          _$CreateCheckInApiResponseImpl
        >
    implements _$$CreateCheckInApiResponseImplCopyWith<$Res> {
  __$$CreateCheckInApiResponseImplCopyWithImpl(
    _$CreateCheckInApiResponseImpl _value,
    $Res Function(_$CreateCheckInApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateCheckInApiResponse
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
      _$CreateCheckInApiResponseImpl(
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
                  as CheckInModel,
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
class _$CreateCheckInApiResponseImpl implements _CreateCheckInApiResponse {
  const _$CreateCheckInApiResponseImpl({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory _$CreateCheckInApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCheckInApiResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final CheckInModel data;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'CreateCheckInApiResponse(success: $success, message: $message, data: $data, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCheckInApiResponseImpl &&
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

  /// Create a copy of CreateCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCheckInApiResponseImplCopyWith<_$CreateCheckInApiResponseImpl>
  get copyWith =>
      __$$CreateCheckInApiResponseImplCopyWithImpl<
        _$CreateCheckInApiResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCheckInApiResponseImplToJson(this);
  }
}

abstract class _CreateCheckInApiResponse implements CreateCheckInApiResponse {
  const factory _CreateCheckInApiResponse({
    required final bool success,
    required final String message,
    required final CheckInModel data,
    required final String timestamp,
  }) = _$CreateCheckInApiResponseImpl;

  factory _CreateCheckInApiResponse.fromJson(Map<String, dynamic> json) =
      _$CreateCheckInApiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  CheckInModel get data;
  @override
  String get timestamp;

  /// Create a copy of CreateCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCheckInApiResponseImplCopyWith<_$CreateCheckInApiResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CheckInsHistoryApiResponse _$CheckInsHistoryApiResponseFromJson(
  Map<String, dynamic> json,
) {
  return _CheckInsHistoryApiResponse.fromJson(json);
}

/// @nodoc
mixin _$CheckInsHistoryApiResponse {
  bool get success => throw _privateConstructorUsedError;
  List<CheckInModel> get data => throw _privateConstructorUsedError;
  PaginationModel get pagination => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this CheckInsHistoryApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CheckInsHistoryApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckInsHistoryApiResponseCopyWith<CheckInsHistoryApiResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInsHistoryApiResponseCopyWith<$Res> {
  factory $CheckInsHistoryApiResponseCopyWith(
    CheckInsHistoryApiResponse value,
    $Res Function(CheckInsHistoryApiResponse) then,
  ) =
      _$CheckInsHistoryApiResponseCopyWithImpl<
        $Res,
        CheckInsHistoryApiResponse
      >;
  @useResult
  $Res call({
    bool success,
    List<CheckInModel> data,
    PaginationModel pagination,
    String timestamp,
  });

  $PaginationModelCopyWith<$Res> get pagination;
}

/// @nodoc
class _$CheckInsHistoryApiResponseCopyWithImpl<
  $Res,
  $Val extends CheckInsHistoryApiResponse
>
    implements $CheckInsHistoryApiResponseCopyWith<$Res> {
  _$CheckInsHistoryApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckInsHistoryApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? pagination = null,
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
                      as List<CheckInModel>,
            pagination: null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                      as PaginationModel,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of CheckInsHistoryApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res> get pagination {
    return $PaginationModelCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckInsHistoryApiResponseImplCopyWith<$Res>
    implements $CheckInsHistoryApiResponseCopyWith<$Res> {
  factory _$$CheckInsHistoryApiResponseImplCopyWith(
    _$CheckInsHistoryApiResponseImpl value,
    $Res Function(_$CheckInsHistoryApiResponseImpl) then,
  ) = __$$CheckInsHistoryApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    List<CheckInModel> data,
    PaginationModel pagination,
    String timestamp,
  });

  @override
  $PaginationModelCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$CheckInsHistoryApiResponseImplCopyWithImpl<$Res>
    extends
        _$CheckInsHistoryApiResponseCopyWithImpl<
          $Res,
          _$CheckInsHistoryApiResponseImpl
        >
    implements _$$CheckInsHistoryApiResponseImplCopyWith<$Res> {
  __$$CheckInsHistoryApiResponseImplCopyWithImpl(
    _$CheckInsHistoryApiResponseImpl _value,
    $Res Function(_$CheckInsHistoryApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckInsHistoryApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? pagination = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$CheckInsHistoryApiResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<CheckInModel>,
        pagination: null == pagination
            ? _value.pagination
            : pagination // ignore: cast_nullable_to_non_nullable
                  as PaginationModel,
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
class _$CheckInsHistoryApiResponseImpl implements _CheckInsHistoryApiResponse {
  const _$CheckInsHistoryApiResponseImpl({
    required this.success,
    required final List<CheckInModel> data,
    required this.pagination,
    required this.timestamp,
  }) : _data = data;

  factory _$CheckInsHistoryApiResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$CheckInsHistoryApiResponseImplFromJson(json);

  @override
  final bool success;
  final List<CheckInModel> _data;
  @override
  List<CheckInModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel pagination;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'CheckInsHistoryApiResponse(success: $success, data: $data, pagination: $pagination, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInsHistoryApiResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(_data),
    pagination,
    timestamp,
  );

  /// Create a copy of CheckInsHistoryApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInsHistoryApiResponseImplCopyWith<_$CheckInsHistoryApiResponseImpl>
  get copyWith =>
      __$$CheckInsHistoryApiResponseImplCopyWithImpl<
        _$CheckInsHistoryApiResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckInsHistoryApiResponseImplToJson(this);
  }
}

abstract class _CheckInsHistoryApiResponse
    implements CheckInsHistoryApiResponse {
  const factory _CheckInsHistoryApiResponse({
    required final bool success,
    required final List<CheckInModel> data,
    required final PaginationModel pagination,
    required final String timestamp,
  }) = _$CheckInsHistoryApiResponseImpl;

  factory _CheckInsHistoryApiResponse.fromJson(Map<String, dynamic> json) =
      _$CheckInsHistoryApiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  List<CheckInModel> get data;
  @override
  PaginationModel get pagination;
  @override
  String get timestamp;

  /// Create a copy of CheckInsHistoryApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckInsHistoryApiResponseImplCopyWith<_$CheckInsHistoryApiResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TodayCheckInApiResponse _$TodayCheckInApiResponseFromJson(
  Map<String, dynamic> json,
) {
  return _TodayCheckInApiResponse.fromJson(json);
}

/// @nodoc
mixin _$TodayCheckInApiResponse {
  bool get success => throw _privateConstructorUsedError;
  CheckInModel? get data => throw _privateConstructorUsedError;
  bool get hasTodayCheckIn => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this TodayCheckInApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodayCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodayCheckInApiResponseCopyWith<TodayCheckInApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayCheckInApiResponseCopyWith<$Res> {
  factory $TodayCheckInApiResponseCopyWith(
    TodayCheckInApiResponse value,
    $Res Function(TodayCheckInApiResponse) then,
  ) = _$TodayCheckInApiResponseCopyWithImpl<$Res, TodayCheckInApiResponse>;
  @useResult
  $Res call({
    bool success,
    CheckInModel? data,
    bool hasTodayCheckIn,
    String timestamp,
  });

  $CheckInModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$TodayCheckInApiResponseCopyWithImpl<
  $Res,
  $Val extends TodayCheckInApiResponse
>
    implements $TodayCheckInApiResponseCopyWith<$Res> {
  _$TodayCheckInApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodayCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? hasTodayCheckIn = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as CheckInModel?,
            hasTodayCheckIn: null == hasTodayCheckIn
                ? _value.hasTodayCheckIn
                : hasTodayCheckIn // ignore: cast_nullable_to_non_nullable
                      as bool,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of TodayCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckInModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $CheckInModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodayCheckInApiResponseImplCopyWith<$Res>
    implements $TodayCheckInApiResponseCopyWith<$Res> {
  factory _$$TodayCheckInApiResponseImplCopyWith(
    _$TodayCheckInApiResponseImpl value,
    $Res Function(_$TodayCheckInApiResponseImpl) then,
  ) = __$$TodayCheckInApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    CheckInModel? data,
    bool hasTodayCheckIn,
    String timestamp,
  });

  @override
  $CheckInModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$TodayCheckInApiResponseImplCopyWithImpl<$Res>
    extends
        _$TodayCheckInApiResponseCopyWithImpl<
          $Res,
          _$TodayCheckInApiResponseImpl
        >
    implements _$$TodayCheckInApiResponseImplCopyWith<$Res> {
  __$$TodayCheckInApiResponseImplCopyWithImpl(
    _$TodayCheckInApiResponseImpl _value,
    $Res Function(_$TodayCheckInApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodayCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? hasTodayCheckIn = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$TodayCheckInApiResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as CheckInModel?,
        hasTodayCheckIn: null == hasTodayCheckIn
            ? _value.hasTodayCheckIn
            : hasTodayCheckIn // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$TodayCheckInApiResponseImpl implements _TodayCheckInApiResponse {
  const _$TodayCheckInApiResponseImpl({
    required this.success,
    this.data,
    required this.hasTodayCheckIn,
    required this.timestamp,
  });

  factory _$TodayCheckInApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodayCheckInApiResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final CheckInModel? data;
  @override
  final bool hasTodayCheckIn;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'TodayCheckInApiResponse(success: $success, data: $data, hasTodayCheckIn: $hasTodayCheckIn, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayCheckInApiResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.hasTodayCheckIn, hasTodayCheckIn) ||
                other.hasTodayCheckIn == hasTodayCheckIn) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, data, hasTodayCheckIn, timestamp);

  /// Create a copy of TodayCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayCheckInApiResponseImplCopyWith<_$TodayCheckInApiResponseImpl>
  get copyWith =>
      __$$TodayCheckInApiResponseImplCopyWithImpl<
        _$TodayCheckInApiResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodayCheckInApiResponseImplToJson(this);
  }
}

abstract class _TodayCheckInApiResponse implements TodayCheckInApiResponse {
  const factory _TodayCheckInApiResponse({
    required final bool success,
    final CheckInModel? data,
    required final bool hasTodayCheckIn,
    required final String timestamp,
  }) = _$TodayCheckInApiResponseImpl;

  factory _TodayCheckInApiResponse.fromJson(Map<String, dynamic> json) =
      _$TodayCheckInApiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  CheckInModel? get data;
  @override
  bool get hasTodayCheckIn;
  @override
  String get timestamp;

  /// Create a copy of TodayCheckInApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodayCheckInApiResponseImplCopyWith<_$TodayCheckInApiResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
