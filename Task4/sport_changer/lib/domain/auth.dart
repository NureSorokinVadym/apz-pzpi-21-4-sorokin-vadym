import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

enum LoginType { admin, personal }

@freezed
class AuthInfo with _$AuthInfo {
  const factory AuthInfo({
    int? id,
    required String token,
    LoginType? loginType,
    @Default([]) List<LoginType> loginVariants,
    String? email,
    String? name,
    String? surname,
  }) = _AuthInfo;

  factory AuthInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoFromJson(json);
}
