// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServerSettingModel {
  String get url => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ServerSettingModelCopyWith<ServerSettingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerSettingModelCopyWith<$Res> {
  factory $ServerSettingModelCopyWith(
          ServerSettingModel value, $Res Function(ServerSettingModel) then) =
      _$ServerSettingModelCopyWithImpl<$Res, ServerSettingModel>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class _$ServerSettingModelCopyWithImpl<$Res, $Val extends ServerSettingModel>
    implements $ServerSettingModelCopyWith<$Res> {
  _$ServerSettingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerSettingImplCopyWith<$Res>
    implements $ServerSettingModelCopyWith<$Res> {
  factory _$$ServerSettingImplCopyWith(
          _$ServerSettingImpl value, $Res Function(_$ServerSettingImpl) then) =
      __$$ServerSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$ServerSettingImplCopyWithImpl<$Res>
    extends _$ServerSettingModelCopyWithImpl<$Res, _$ServerSettingImpl>
    implements _$$ServerSettingImplCopyWith<$Res> {
  __$$ServerSettingImplCopyWithImpl(
      _$ServerSettingImpl _value, $Res Function(_$ServerSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$ServerSettingImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ServerSettingImpl implements _ServerSetting {
  const _$ServerSettingImpl({required this.url});

  @override
  final String url;

  @override
  String toString() {
    return 'ServerSettingModel(url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerSettingImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerSettingImplCopyWith<_$ServerSettingImpl> get copyWith =>
      __$$ServerSettingImplCopyWithImpl<_$ServerSettingImpl>(this, _$identity);
}

abstract class _ServerSetting implements ServerSettingModel {
  const factory _ServerSetting({required final String url}) =
      _$ServerSettingImpl;

  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$ServerSettingImplCopyWith<_$ServerSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
