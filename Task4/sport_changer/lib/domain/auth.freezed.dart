// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) {
  return _AuthInfo.fromJson(json);
}

/// @nodoc
mixin _$AuthInfo {
  int? get id => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  LoginType? get loginType => throw _privateConstructorUsedError;
  List<LoginType> get loginVariants => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthInfoCopyWith<AuthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthInfoCopyWith<$Res> {
  factory $AuthInfoCopyWith(AuthInfo value, $Res Function(AuthInfo) then) =
      _$AuthInfoCopyWithImpl<$Res, AuthInfo>;
  @useResult
  $Res call(
      {int? id,
      String token,
      LoginType? loginType,
      List<LoginType> loginVariants,
      String? email,
      String? name,
      String? surname});
}

/// @nodoc
class _$AuthInfoCopyWithImpl<$Res, $Val extends AuthInfo>
    implements $AuthInfoCopyWith<$Res> {
  _$AuthInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? token = null,
    Object? loginType = freezed,
    Object? loginVariants = null,
    Object? email = freezed,
    Object? name = freezed,
    Object? surname = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      loginType: freezed == loginType
          ? _value.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as LoginType?,
      loginVariants: null == loginVariants
          ? _value.loginVariants
          : loginVariants // ignore: cast_nullable_to_non_nullable
              as List<LoginType>,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthInfoImplCopyWith<$Res>
    implements $AuthInfoCopyWith<$Res> {
  factory _$$AuthInfoImplCopyWith(
          _$AuthInfoImpl value, $Res Function(_$AuthInfoImpl) then) =
      __$$AuthInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String token,
      LoginType? loginType,
      List<LoginType> loginVariants,
      String? email,
      String? name,
      String? surname});
}

/// @nodoc
class __$$AuthInfoImplCopyWithImpl<$Res>
    extends _$AuthInfoCopyWithImpl<$Res, _$AuthInfoImpl>
    implements _$$AuthInfoImplCopyWith<$Res> {
  __$$AuthInfoImplCopyWithImpl(
      _$AuthInfoImpl _value, $Res Function(_$AuthInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? token = null,
    Object? loginType = freezed,
    Object? loginVariants = null,
    Object? email = freezed,
    Object? name = freezed,
    Object? surname = freezed,
  }) {
    return _then(_$AuthInfoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      loginType: freezed == loginType
          ? _value.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as LoginType?,
      loginVariants: null == loginVariants
          ? _value._loginVariants
          : loginVariants // ignore: cast_nullable_to_non_nullable
              as List<LoginType>,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthInfoImpl implements _AuthInfo {
  const _$AuthInfoImpl(
      {this.id,
      required this.token,
      this.loginType,
      final List<LoginType> loginVariants = const [],
      this.email,
      this.name,
      this.surname})
      : _loginVariants = loginVariants;

  factory _$AuthInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthInfoImplFromJson(json);

  @override
  final int? id;
  @override
  final String token;
  @override
  final LoginType? loginType;
  final List<LoginType> _loginVariants;
  @override
  @JsonKey()
  List<LoginType> get loginVariants {
    if (_loginVariants is EqualUnmodifiableListView) return _loginVariants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loginVariants);
  }

  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? surname;

  @override
  String toString() {
    return 'AuthInfo(id: $id, token: $token, loginType: $loginType, loginVariants: $loginVariants, email: $email, name: $name, surname: $surname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            const DeepCollectionEquality()
                .equals(other._loginVariants, _loginVariants) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      token,
      loginType,
      const DeepCollectionEquality().hash(_loginVariants),
      email,
      name,
      surname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthInfoImplCopyWith<_$AuthInfoImpl> get copyWith =>
      __$$AuthInfoImplCopyWithImpl<_$AuthInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthInfoImplToJson(
      this,
    );
  }
}

abstract class _AuthInfo implements AuthInfo {
  const factory _AuthInfo(
      {final int? id,
      required final String token,
      final LoginType? loginType,
      final List<LoginType> loginVariants,
      final String? email,
      final String? name,
      final String? surname}) = _$AuthInfoImpl;

  factory _AuthInfo.fromJson(Map<String, dynamic> json) =
      _$AuthInfoImpl.fromJson;

  @override
  int? get id;
  @override
  String get token;
  @override
  LoginType? get loginType;
  @override
  List<LoginType> get loginVariants;
  @override
  String? get email;
  @override
  String? get name;
  @override
  String? get surname;
  @override
  @JsonKey(ignore: true)
  _$$AuthInfoImplCopyWith<_$AuthInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
