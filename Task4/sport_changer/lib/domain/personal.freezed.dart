// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Client _$ClientFromJson(Map<String, dynamic> json) {
  return _Client.fromJson(json);
}

/// @nodoc
mixin _$Client {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  List<UserExercise> get exercises => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientCopyWith<Client> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientCopyWith<$Res> {
  factory $ClientCopyWith(Client value, $Res Function(Client) then) =
      _$ClientCopyWithImpl<$Res, Client>;
  @useResult
  $Res call(
      {int id,
      String? name,
      String? surname,
      String? email,
      List<UserExercise> exercises});
}

/// @nodoc
class _$ClientCopyWithImpl<$Res, $Val extends Client>
    implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? exercises = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      exercises: null == exercises
          ? _value.exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<UserExercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientImplCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$$ClientImplCopyWith(
          _$ClientImpl value, $Res Function(_$ClientImpl) then) =
      __$$ClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      String? surname,
      String? email,
      List<UserExercise> exercises});
}

/// @nodoc
class __$$ClientImplCopyWithImpl<$Res>
    extends _$ClientCopyWithImpl<$Res, _$ClientImpl>
    implements _$$ClientImplCopyWith<$Res> {
  __$$ClientImplCopyWithImpl(
      _$ClientImpl _value, $Res Function(_$ClientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? exercises = null,
  }) {
    return _then(_$ClientImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      exercises: null == exercises
          ? _value._exercises
          : exercises // ignore: cast_nullable_to_non_nullable
              as List<UserExercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientImpl implements _Client {
  const _$ClientImpl(
      {required this.id,
      this.name,
      this.surname,
      this.email,
      final List<UserExercise> exercises = const []})
      : _exercises = exercises;

  factory _$ClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? surname;
  @override
  final String? email;
  final List<UserExercise> _exercises;
  @override
  @JsonKey()
  List<UserExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  String toString() {
    return 'Client(id: $id, name: $name, surname: $surname, email: $email, exercises: $exercises)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other._exercises, _exercises));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, surname, email,
      const DeepCollectionEquality().hash(_exercises));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      __$$ClientImplCopyWithImpl<_$ClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientImplToJson(
      this,
    );
  }
}

abstract class _Client implements Client {
  const factory _Client(
      {required final int id,
      final String? name,
      final String? surname,
      final String? email,
      final List<UserExercise> exercises}) = _$ClientImpl;

  factory _Client.fromJson(Map<String, dynamic> json) = _$ClientImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get surname;
  @override
  String? get email;
  @override
  List<UserExercise> get exercises;
  @override
  @JsonKey(ignore: true)
  _$$ClientImplCopyWith<_$ClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get measurement => throw _privateConstructorUsedError;
  int? get exerciseTypeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call({int? id, String name, String? measurement, int? exerciseTypeId});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? measurement = freezed,
    Object? exerciseTypeId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      measurement: freezed == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as String?,
      exerciseTypeId: freezed == exerciseTypeId
          ? _value.exerciseTypeId
          : exerciseTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String name, String? measurement, int? exerciseTypeId});
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? measurement = freezed,
    Object? exerciseTypeId = freezed,
  }) {
    return _then(_$ExerciseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      measurement: freezed == measurement
          ? _value.measurement
          : measurement // ignore: cast_nullable_to_non_nullable
              as String?,
      exerciseTypeId: freezed == exerciseTypeId
          ? _value.exerciseTypeId
          : exerciseTypeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
      {this.id, required this.name, this.measurement, this.exerciseTypeId});

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String? measurement;
  @override
  final int? exerciseTypeId;

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, measurement: $measurement, exerciseTypeId: $exerciseTypeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.measurement, measurement) ||
                other.measurement == measurement) &&
            (identical(other.exerciseTypeId, exerciseTypeId) ||
                other.exerciseTypeId == exerciseTypeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, measurement, exerciseTypeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {final int? id,
      required final String name,
      final String? measurement,
      final int? exerciseTypeId}) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  String? get measurement;
  @override
  int? get exerciseTypeId;
  @override
  @JsonKey(ignore: true)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserExercise _$UserExerciseFromJson(Map<String, dynamic> json) {
  return _UserExercise.fromJson(json);
}

/// @nodoc
mixin _$UserExercise {
  int get id => throw _privateConstructorUsedError;
  Exercise? get exercise => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;
  int get pulse => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserExerciseCopyWith<UserExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserExerciseCopyWith<$Res> {
  factory $UserExerciseCopyWith(
          UserExercise value, $Res Function(UserExercise) then) =
      _$UserExerciseCopyWithImpl<$Res, UserExercise>;
  @useResult
  $Res call(
      {int id,
      Exercise? exercise,
      Duration duration,
      int number,
      int weight,
      int pulse,
      String date});

  $ExerciseCopyWith<$Res>? get exercise;
}

/// @nodoc
class _$UserExerciseCopyWithImpl<$Res, $Val extends UserExercise>
    implements $UserExerciseCopyWith<$Res> {
  _$UserExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exercise = freezed,
    Object? duration = null,
    Object? number = null,
    Object? weight = null,
    Object? pulse = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      exercise: freezed == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      pulse: null == pulse
          ? _value.pulse
          : pulse // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<$Res>? get exercise {
    if (_value.exercise == null) {
      return null;
    }

    return $ExerciseCopyWith<$Res>(_value.exercise!, (value) {
      return _then(_value.copyWith(exercise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserExerciseImplCopyWith<$Res>
    implements $UserExerciseCopyWith<$Res> {
  factory _$$UserExerciseImplCopyWith(
          _$UserExerciseImpl value, $Res Function(_$UserExerciseImpl) then) =
      __$$UserExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      Exercise? exercise,
      Duration duration,
      int number,
      int weight,
      int pulse,
      String date});

  @override
  $ExerciseCopyWith<$Res>? get exercise;
}

/// @nodoc
class __$$UserExerciseImplCopyWithImpl<$Res>
    extends _$UserExerciseCopyWithImpl<$Res, _$UserExerciseImpl>
    implements _$$UserExerciseImplCopyWith<$Res> {
  __$$UserExerciseImplCopyWithImpl(
      _$UserExerciseImpl _value, $Res Function(_$UserExerciseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exercise = freezed,
    Object? duration = null,
    Object? number = null,
    Object? weight = null,
    Object? pulse = null,
    Object? date = null,
  }) {
    return _then(_$UserExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      exercise: freezed == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      pulse: null == pulse
          ? _value.pulse
          : pulse // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserExerciseImpl implements _UserExercise {
  const _$UserExerciseImpl(
      {required this.id,
      this.exercise,
      this.duration = const Duration(),
      this.number = 0,
      this.weight = 0,
      this.pulse = 0,
      required this.date});

  factory _$UserExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserExerciseImplFromJson(json);

  @override
  final int id;
  @override
  final Exercise? exercise;
  @override
  @JsonKey()
  final Duration duration;
  @override
  @JsonKey()
  final int number;
  @override
  @JsonKey()
  final int weight;
  @override
  @JsonKey()
  final int pulse;
  @override
  final String date;

  @override
  String toString() {
    return 'UserExercise(id: $id, exercise: $exercise, duration: $duration, number: $number, weight: $weight, pulse: $pulse, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.pulse, pulse) || other.pulse == pulse) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, exercise, duration, number, weight, pulse, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserExerciseImplCopyWith<_$UserExerciseImpl> get copyWith =>
      __$$UserExerciseImplCopyWithImpl<_$UserExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserExerciseImplToJson(
      this,
    );
  }
}

abstract class _UserExercise implements UserExercise {
  const factory _UserExercise(
      {required final int id,
      final Exercise? exercise,
      final Duration duration,
      final int number,
      final int weight,
      final int pulse,
      required final String date}) = _$UserExerciseImpl;

  factory _UserExercise.fromJson(Map<String, dynamic> json) =
      _$UserExerciseImpl.fromJson;

  @override
  int get id;
  @override
  Exercise? get exercise;
  @override
  Duration get duration;
  @override
  int get number;
  @override
  int get weight;
  @override
  int get pulse;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$$UserExerciseImplCopyWith<_$UserExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
