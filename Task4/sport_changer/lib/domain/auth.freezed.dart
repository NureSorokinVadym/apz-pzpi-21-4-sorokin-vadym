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

/// @nodoc
mixin _$AuthInfo {
  String get token => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthInfoCopyWith<AuthInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthInfoCopyWith<$Res> {
  factory $AuthInfoCopyWith(AuthInfo value, $Res Function(AuthInfo) then) =
      _$AuthInfoCopyWithImpl<$Res, AuthInfo>;
  @useResult
  $Res call({String token});
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
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({String token});
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
    Object? token = null,
  }) {
    return _then(_$AuthInfoImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthInfoImpl implements _AuthInfo {
  const _$AuthInfoImpl({required this.token});

  @override
  final String token;

  @override
  String toString() {
    return 'AuthInfo(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthInfoImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthInfoImplCopyWith<_$AuthInfoImpl> get copyWith =>
      __$$AuthInfoImplCopyWithImpl<_$AuthInfoImpl>(this, _$identity);
}

abstract class _AuthInfo implements AuthInfo {
  const factory _AuthInfo({required final String token}) = _$AuthInfoImpl;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$AuthInfoImplCopyWith<_$AuthInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
