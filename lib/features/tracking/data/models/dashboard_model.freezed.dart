// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardSummaryModel _$DashboardSummaryModelFromJson(
  Map<String, dynamic> json,
) {
  return _DashboardSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardSummaryModel {
  bool get hasTodayCheckIn => throw _privateConstructorUsedError;
  CheckInModel? get todayCheckIn => throw _privateConstructorUsedError;
  int get totalCheckIns => throw _privateConstructorUsedError;
  int get totalEmotionalCalendarEntries => throw _privateConstructorUsedError;
  double get averageEmotionalLevel => throw _privateConstructorUsedError;
  double get averageEnergyLevel => throw _privateConstructorUsedError;
  double get averageMoodLevel => throw _privateConstructorUsedError;
  List<String> get mostCommonSymptoms => throw _privateConstructorUsedError;
  List<String> get mostUsedEmotionalTags => throw _privateConstructorUsedError;

  /// Serializes this DashboardSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSummaryModelCopyWith<DashboardSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryModelCopyWith<$Res> {
  factory $DashboardSummaryModelCopyWith(
    DashboardSummaryModel value,
    $Res Function(DashboardSummaryModel) then,
  ) = _$DashboardSummaryModelCopyWithImpl<$Res, DashboardSummaryModel>;
  @useResult
  $Res call({
    bool hasTodayCheckIn,
    CheckInModel? todayCheckIn,
    int totalCheckIns,
    int totalEmotionalCalendarEntries,
    double averageEmotionalLevel,
    double averageEnergyLevel,
    double averageMoodLevel,
    List<String> mostCommonSymptoms,
    List<String> mostUsedEmotionalTags,
  });

  $CheckInModelCopyWith<$Res>? get todayCheckIn;
}

/// @nodoc
class _$DashboardSummaryModelCopyWithImpl<
  $Res,
  $Val extends DashboardSummaryModel
>
    implements $DashboardSummaryModelCopyWith<$Res> {
  _$DashboardSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasTodayCheckIn = null,
    Object? todayCheckIn = freezed,
    Object? totalCheckIns = null,
    Object? totalEmotionalCalendarEntries = null,
    Object? averageEmotionalLevel = null,
    Object? averageEnergyLevel = null,
    Object? averageMoodLevel = null,
    Object? mostCommonSymptoms = null,
    Object? mostUsedEmotionalTags = null,
  }) {
    return _then(
      _value.copyWith(
            hasTodayCheckIn: null == hasTodayCheckIn
                ? _value.hasTodayCheckIn
                : hasTodayCheckIn // ignore: cast_nullable_to_non_nullable
                      as bool,
            todayCheckIn: freezed == todayCheckIn
                ? _value.todayCheckIn
                : todayCheckIn // ignore: cast_nullable_to_non_nullable
                      as CheckInModel?,
            totalCheckIns: null == totalCheckIns
                ? _value.totalCheckIns
                : totalCheckIns // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEmotionalCalendarEntries: null == totalEmotionalCalendarEntries
                ? _value.totalEmotionalCalendarEntries
                : totalEmotionalCalendarEntries // ignore: cast_nullable_to_non_nullable
                      as int,
            averageEmotionalLevel: null == averageEmotionalLevel
                ? _value.averageEmotionalLevel
                : averageEmotionalLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            averageEnergyLevel: null == averageEnergyLevel
                ? _value.averageEnergyLevel
                : averageEnergyLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            averageMoodLevel: null == averageMoodLevel
                ? _value.averageMoodLevel
                : averageMoodLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            mostCommonSymptoms: null == mostCommonSymptoms
                ? _value.mostCommonSymptoms
                : mostCommonSymptoms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mostUsedEmotionalTags: null == mostUsedEmotionalTags
                ? _value.mostUsedEmotionalTags
                : mostUsedEmotionalTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CheckInModelCopyWith<$Res>? get todayCheckIn {
    if (_value.todayCheckIn == null) {
      return null;
    }

    return $CheckInModelCopyWith<$Res>(_value.todayCheckIn!, (value) {
      return _then(_value.copyWith(todayCheckIn: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardSummaryModelImplCopyWith<$Res>
    implements $DashboardSummaryModelCopyWith<$Res> {
  factory _$$DashboardSummaryModelImplCopyWith(
    _$DashboardSummaryModelImpl value,
    $Res Function(_$DashboardSummaryModelImpl) then,
  ) = __$$DashboardSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool hasTodayCheckIn,
    CheckInModel? todayCheckIn,
    int totalCheckIns,
    int totalEmotionalCalendarEntries,
    double averageEmotionalLevel,
    double averageEnergyLevel,
    double averageMoodLevel,
    List<String> mostCommonSymptoms,
    List<String> mostUsedEmotionalTags,
  });

  @override
  $CheckInModelCopyWith<$Res>? get todayCheckIn;
}

/// @nodoc
class __$$DashboardSummaryModelImplCopyWithImpl<$Res>
    extends
        _$DashboardSummaryModelCopyWithImpl<$Res, _$DashboardSummaryModelImpl>
    implements _$$DashboardSummaryModelImplCopyWith<$Res> {
  __$$DashboardSummaryModelImplCopyWithImpl(
    _$DashboardSummaryModelImpl _value,
    $Res Function(_$DashboardSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasTodayCheckIn = null,
    Object? todayCheckIn = freezed,
    Object? totalCheckIns = null,
    Object? totalEmotionalCalendarEntries = null,
    Object? averageEmotionalLevel = null,
    Object? averageEnergyLevel = null,
    Object? averageMoodLevel = null,
    Object? mostCommonSymptoms = null,
    Object? mostUsedEmotionalTags = null,
  }) {
    return _then(
      _$DashboardSummaryModelImpl(
        hasTodayCheckIn: null == hasTodayCheckIn
            ? _value.hasTodayCheckIn
            : hasTodayCheckIn // ignore: cast_nullable_to_non_nullable
                  as bool,
        todayCheckIn: freezed == todayCheckIn
            ? _value.todayCheckIn
            : todayCheckIn // ignore: cast_nullable_to_non_nullable
                  as CheckInModel?,
        totalCheckIns: null == totalCheckIns
            ? _value.totalCheckIns
            : totalCheckIns // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEmotionalCalendarEntries: null == totalEmotionalCalendarEntries
            ? _value.totalEmotionalCalendarEntries
            : totalEmotionalCalendarEntries // ignore: cast_nullable_to_non_nullable
                  as int,
        averageEmotionalLevel: null == averageEmotionalLevel
            ? _value.averageEmotionalLevel
            : averageEmotionalLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        averageEnergyLevel: null == averageEnergyLevel
            ? _value.averageEnergyLevel
            : averageEnergyLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        averageMoodLevel: null == averageMoodLevel
            ? _value.averageMoodLevel
            : averageMoodLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        mostCommonSymptoms: null == mostCommonSymptoms
            ? _value._mostCommonSymptoms
            : mostCommonSymptoms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mostUsedEmotionalTags: null == mostUsedEmotionalTags
            ? _value._mostUsedEmotionalTags
            : mostUsedEmotionalTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSummaryModelImpl implements _DashboardSummaryModel {
  const _$DashboardSummaryModelImpl({
    required this.hasTodayCheckIn,
    this.todayCheckIn,
    required this.totalCheckIns,
    required this.totalEmotionalCalendarEntries,
    required this.averageEmotionalLevel,
    required this.averageEnergyLevel,
    required this.averageMoodLevel,
    required final List<String> mostCommonSymptoms,
    required final List<String> mostUsedEmotionalTags,
  }) : _mostCommonSymptoms = mostCommonSymptoms,
       _mostUsedEmotionalTags = mostUsedEmotionalTags;

  factory _$DashboardSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSummaryModelImplFromJson(json);

  @override
  final bool hasTodayCheckIn;
  @override
  final CheckInModel? todayCheckIn;
  @override
  final int totalCheckIns;
  @override
  final int totalEmotionalCalendarEntries;
  @override
  final double averageEmotionalLevel;
  @override
  final double averageEnergyLevel;
  @override
  final double averageMoodLevel;
  final List<String> _mostCommonSymptoms;
  @override
  List<String> get mostCommonSymptoms {
    if (_mostCommonSymptoms is EqualUnmodifiableListView)
      return _mostCommonSymptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostCommonSymptoms);
  }

  final List<String> _mostUsedEmotionalTags;
  @override
  List<String> get mostUsedEmotionalTags {
    if (_mostUsedEmotionalTags is EqualUnmodifiableListView)
      return _mostUsedEmotionalTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostUsedEmotionalTags);
  }

  @override
  String toString() {
    return 'DashboardSummaryModel(hasTodayCheckIn: $hasTodayCheckIn, todayCheckIn: $todayCheckIn, totalCheckIns: $totalCheckIns, totalEmotionalCalendarEntries: $totalEmotionalCalendarEntries, averageEmotionalLevel: $averageEmotionalLevel, averageEnergyLevel: $averageEnergyLevel, averageMoodLevel: $averageMoodLevel, mostCommonSymptoms: $mostCommonSymptoms, mostUsedEmotionalTags: $mostUsedEmotionalTags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryModelImpl &&
            (identical(other.hasTodayCheckIn, hasTodayCheckIn) ||
                other.hasTodayCheckIn == hasTodayCheckIn) &&
            (identical(other.todayCheckIn, todayCheckIn) ||
                other.todayCheckIn == todayCheckIn) &&
            (identical(other.totalCheckIns, totalCheckIns) ||
                other.totalCheckIns == totalCheckIns) &&
            (identical(
                  other.totalEmotionalCalendarEntries,
                  totalEmotionalCalendarEntries,
                ) ||
                other.totalEmotionalCalendarEntries ==
                    totalEmotionalCalendarEntries) &&
            (identical(other.averageEmotionalLevel, averageEmotionalLevel) ||
                other.averageEmotionalLevel == averageEmotionalLevel) &&
            (identical(other.averageEnergyLevel, averageEnergyLevel) ||
                other.averageEnergyLevel == averageEnergyLevel) &&
            (identical(other.averageMoodLevel, averageMoodLevel) ||
                other.averageMoodLevel == averageMoodLevel) &&
            const DeepCollectionEquality().equals(
              other._mostCommonSymptoms,
              _mostCommonSymptoms,
            ) &&
            const DeepCollectionEquality().equals(
              other._mostUsedEmotionalTags,
              _mostUsedEmotionalTags,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasTodayCheckIn,
    todayCheckIn,
    totalCheckIns,
    totalEmotionalCalendarEntries,
    averageEmotionalLevel,
    averageEnergyLevel,
    averageMoodLevel,
    const DeepCollectionEquality().hash(_mostCommonSymptoms),
    const DeepCollectionEquality().hash(_mostUsedEmotionalTags),
  );

  /// Create a copy of DashboardSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryModelImplCopyWith<_$DashboardSummaryModelImpl>
  get copyWith =>
      __$$DashboardSummaryModelImplCopyWithImpl<_$DashboardSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSummaryModelImplToJson(this);
  }
}

abstract class _DashboardSummaryModel implements DashboardSummaryModel {
  const factory _DashboardSummaryModel({
    required final bool hasTodayCheckIn,
    final CheckInModel? todayCheckIn,
    required final int totalCheckIns,
    required final int totalEmotionalCalendarEntries,
    required final double averageEmotionalLevel,
    required final double averageEnergyLevel,
    required final double averageMoodLevel,
    required final List<String> mostCommonSymptoms,
    required final List<String> mostUsedEmotionalTags,
  }) = _$DashboardSummaryModelImpl;

  factory _DashboardSummaryModel.fromJson(Map<String, dynamic> json) =
      _$DashboardSummaryModelImpl.fromJson;

  @override
  bool get hasTodayCheckIn;
  @override
  CheckInModel? get todayCheckIn;
  @override
  int get totalCheckIns;
  @override
  int get totalEmotionalCalendarEntries;
  @override
  double get averageEmotionalLevel;
  @override
  double get averageEnergyLevel;
  @override
  double get averageMoodLevel;
  @override
  List<String> get mostCommonSymptoms;
  @override
  List<String> get mostUsedEmotionalTags;

  /// Create a copy of DashboardSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSummaryModelImplCopyWith<_$DashboardSummaryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DashboardInsightsModel _$DashboardInsightsModelFromJson(
  Map<String, dynamic> json,
) {
  return _DashboardInsightsModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardInsightsModel {
  List<String> get messages => throw _privateConstructorUsedError;

  /// Serializes this DashboardInsightsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardInsightsModelCopyWith<DashboardInsightsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardInsightsModelCopyWith<$Res> {
  factory $DashboardInsightsModelCopyWith(
    DashboardInsightsModel value,
    $Res Function(DashboardInsightsModel) then,
  ) = _$DashboardInsightsModelCopyWithImpl<$Res, DashboardInsightsModel>;
  @useResult
  $Res call({List<String> messages});
}

/// @nodoc
class _$DashboardInsightsModelCopyWithImpl<
  $Res,
  $Val extends DashboardInsightsModel
>
    implements $DashboardInsightsModelCopyWith<$Res> {
  _$DashboardInsightsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _value.copyWith(
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardInsightsModelImplCopyWith<$Res>
    implements $DashboardInsightsModelCopyWith<$Res> {
  factory _$$DashboardInsightsModelImplCopyWith(
    _$DashboardInsightsModelImpl value,
    $Res Function(_$DashboardInsightsModelImpl) then,
  ) = __$$DashboardInsightsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> messages});
}

/// @nodoc
class __$$DashboardInsightsModelImplCopyWithImpl<$Res>
    extends
        _$DashboardInsightsModelCopyWithImpl<$Res, _$DashboardInsightsModelImpl>
    implements _$$DashboardInsightsModelImplCopyWith<$Res> {
  __$$DashboardInsightsModelImplCopyWithImpl(
    _$DashboardInsightsModelImpl _value,
    $Res Function(_$DashboardInsightsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null}) {
    return _then(
      _$DashboardInsightsModelImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardInsightsModelImpl implements _DashboardInsightsModel {
  const _$DashboardInsightsModelImpl({required final List<String> messages})
    : _messages = messages;

  factory _$DashboardInsightsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardInsightsModelImplFromJson(json);

  final List<String> _messages;
  @override
  List<String> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'DashboardInsightsModel(messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardInsightsModelImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  /// Create a copy of DashboardInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardInsightsModelImplCopyWith<_$DashboardInsightsModelImpl>
  get copyWith =>
      __$$DashboardInsightsModelImplCopyWithImpl<_$DashboardInsightsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardInsightsModelImplToJson(this);
  }
}

abstract class _DashboardInsightsModel implements DashboardInsightsModel {
  const factory _DashboardInsightsModel({
    required final List<String> messages,
  }) = _$DashboardInsightsModelImpl;

  factory _DashboardInsightsModel.fromJson(Map<String, dynamic> json) =
      _$DashboardInsightsModelImpl.fromJson;

  @override
  List<String> get messages;

  /// Create a copy of DashboardInsightsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardInsightsModelImplCopyWith<_$DashboardInsightsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) {
  return _DashboardDataModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardDataModel {
  DashboardSummaryModel get summary => throw _privateConstructorUsedError;
  DashboardInsightsModel get insights => throw _privateConstructorUsedError;

  /// Serializes this DashboardDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardDataModelCopyWith<DashboardDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataModelCopyWith<$Res> {
  factory $DashboardDataModelCopyWith(
    DashboardDataModel value,
    $Res Function(DashboardDataModel) then,
  ) = _$DashboardDataModelCopyWithImpl<$Res, DashboardDataModel>;
  @useResult
  $Res call({DashboardSummaryModel summary, DashboardInsightsModel insights});

  $DashboardSummaryModelCopyWith<$Res> get summary;
  $DashboardInsightsModelCopyWith<$Res> get insights;
}

/// @nodoc
class _$DashboardDataModelCopyWithImpl<$Res, $Val extends DashboardDataModel>
    implements $DashboardDataModelCopyWith<$Res> {
  _$DashboardDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? insights = null}) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as DashboardSummaryModel,
            insights: null == insights
                ? _value.insights
                : insights // ignore: cast_nullable_to_non_nullable
                      as DashboardInsightsModel,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardSummaryModelCopyWith<$Res> get summary {
    return $DashboardSummaryModelCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardInsightsModelCopyWith<$Res> get insights {
    return $DashboardInsightsModelCopyWith<$Res>(_value.insights, (value) {
      return _then(_value.copyWith(insights: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardDataModelImplCopyWith<$Res>
    implements $DashboardDataModelCopyWith<$Res> {
  factory _$$DashboardDataModelImplCopyWith(
    _$DashboardDataModelImpl value,
    $Res Function(_$DashboardDataModelImpl) then,
  ) = __$$DashboardDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DashboardSummaryModel summary, DashboardInsightsModel insights});

  @override
  $DashboardSummaryModelCopyWith<$Res> get summary;
  @override
  $DashboardInsightsModelCopyWith<$Res> get insights;
}

/// @nodoc
class __$$DashboardDataModelImplCopyWithImpl<$Res>
    extends _$DashboardDataModelCopyWithImpl<$Res, _$DashboardDataModelImpl>
    implements _$$DashboardDataModelImplCopyWith<$Res> {
  __$$DashboardDataModelImplCopyWithImpl(
    _$DashboardDataModelImpl _value,
    $Res Function(_$DashboardDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null, Object? insights = null}) {
    return _then(
      _$DashboardDataModelImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as DashboardSummaryModel,
        insights: null == insights
            ? _value.insights
            : insights // ignore: cast_nullable_to_non_nullable
                  as DashboardInsightsModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardDataModelImpl implements _DashboardDataModel {
  const _$DashboardDataModelImpl({
    required this.summary,
    required this.insights,
  });

  factory _$DashboardDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardDataModelImplFromJson(json);

  @override
  final DashboardSummaryModel summary;
  @override
  final DashboardInsightsModel insights;

  @override
  String toString() {
    return 'DashboardDataModel(summary: $summary, insights: $insights)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataModelImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.insights, insights) ||
                other.insights == insights));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, summary, insights);

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataModelImplCopyWith<_$DashboardDataModelImpl> get copyWith =>
      __$$DashboardDataModelImplCopyWithImpl<_$DashboardDataModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardDataModelImplToJson(this);
  }
}

abstract class _DashboardDataModel implements DashboardDataModel {
  const factory _DashboardDataModel({
    required final DashboardSummaryModel summary,
    required final DashboardInsightsModel insights,
  }) = _$DashboardDataModelImpl;

  factory _DashboardDataModel.fromJson(Map<String, dynamic> json) =
      _$DashboardDataModelImpl.fromJson;

  @override
  DashboardSummaryModel get summary;
  @override
  DashboardInsightsModel get insights;

  /// Create a copy of DashboardDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardDataModelImplCopyWith<_$DashboardDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardApiResponse _$DashboardApiResponseFromJson(Map<String, dynamic> json) {
  return _DashboardApiResponse.fromJson(json);
}

/// @nodoc
mixin _$DashboardApiResponse {
  bool get success => throw _privateConstructorUsedError;
  DashboardDataModel get data => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this DashboardApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardApiResponseCopyWith<DashboardApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardApiResponseCopyWith<$Res> {
  factory $DashboardApiResponseCopyWith(
    DashboardApiResponse value,
    $Res Function(DashboardApiResponse) then,
  ) = _$DashboardApiResponseCopyWithImpl<$Res, DashboardApiResponse>;
  @useResult
  $Res call({bool success, DashboardDataModel data, String timestamp});

  $DashboardDataModelCopyWith<$Res> get data;
}

/// @nodoc
class _$DashboardApiResponseCopyWithImpl<
  $Res,
  $Val extends DashboardApiResponse
>
    implements $DashboardApiResponseCopyWith<$Res> {
  _$DashboardApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardApiResponse
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
                      as DashboardDataModel,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardDataModelCopyWith<$Res> get data {
    return $DashboardDataModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardApiResponseImplCopyWith<$Res>
    implements $DashboardApiResponseCopyWith<$Res> {
  factory _$$DashboardApiResponseImplCopyWith(
    _$DashboardApiResponseImpl value,
    $Res Function(_$DashboardApiResponseImpl) then,
  ) = __$$DashboardApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, DashboardDataModel data, String timestamp});

  @override
  $DashboardDataModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$DashboardApiResponseImplCopyWithImpl<$Res>
    extends _$DashboardApiResponseCopyWithImpl<$Res, _$DashboardApiResponseImpl>
    implements _$$DashboardApiResponseImplCopyWith<$Res> {
  __$$DashboardApiResponseImplCopyWithImpl(
    _$DashboardApiResponseImpl _value,
    $Res Function(_$DashboardApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$DashboardApiResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as DashboardDataModel,
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
class _$DashboardApiResponseImpl implements _DashboardApiResponse {
  const _$DashboardApiResponseImpl({
    required this.success,
    required this.data,
    required this.timestamp,
  });

  factory _$DashboardApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardApiResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final DashboardDataModel data;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'DashboardApiResponse(success: $success, data: $data, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardApiResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, timestamp);

  /// Create a copy of DashboardApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardApiResponseImplCopyWith<_$DashboardApiResponseImpl>
  get copyWith =>
      __$$DashboardApiResponseImplCopyWithImpl<_$DashboardApiResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardApiResponseImplToJson(this);
  }
}

abstract class _DashboardApiResponse implements DashboardApiResponse {
  const factory _DashboardApiResponse({
    required final bool success,
    required final DashboardDataModel data,
    required final String timestamp,
  }) = _$DashboardApiResponseImpl;

  factory _DashboardApiResponse.fromJson(Map<String, dynamic> json) =
      _$DashboardApiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  DashboardDataModel get data;
  @override
  String get timestamp;

  /// Create a copy of DashboardApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardApiResponseImplCopyWith<_$DashboardApiResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
