// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthInfoImpl _$$AuthInfoImplFromJson(Map<String, dynamic> json) =>
    _$AuthInfoImpl(
      id: (json['id'] as num?)?.toInt(),
      token: json['token'] as String,
      loginType: $enumDecodeNullable(_$LoginTypeEnumMap, json['loginType']),
      loginVariants: (json['loginVariants'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$LoginTypeEnumMap, e))
              .toList() ??
          const [],
      email: json['email'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
    );

Map<String, dynamic> _$$AuthInfoImplToJson(_$AuthInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'loginType': _$LoginTypeEnumMap[instance.loginType],
      'loginVariants':
          instance.loginVariants.map((e) => _$LoginTypeEnumMap[e]!).toList(),
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
    };

const _$LoginTypeEnumMap = {
  LoginType.admin: 'admin',
  LoginType.personal: 'personal',
};
