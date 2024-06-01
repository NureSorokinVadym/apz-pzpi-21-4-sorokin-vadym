// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalImpl _$$PersonalImplFromJson(Map<String, dynamic> json) =>
    _$PersonalImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num).toInt(),
      specificationId: (json['specification_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PersonalImplToJson(_$PersonalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'specification_id': instance.specificationId,
    };
