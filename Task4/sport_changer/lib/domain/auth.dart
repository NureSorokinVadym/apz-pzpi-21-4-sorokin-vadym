import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

@freezed
class AuthInfo with _$AuthInfo {
  const factory AuthInfo({
    required String token,
  }) = _AuthInfo;
}
