import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.freezed.dart';
part 'admin.g.dart';

@freezed
class Personal with _$Personal {
  const factory Personal(
      {int? id,
      required int user_id,
      @JsonKey(name: 'specification_id') int? specificationId}) = _Personal;
  factory Personal.fromJson(Map<String, dynamic> json) =>
      _$PersonalFromJson(json);
}
