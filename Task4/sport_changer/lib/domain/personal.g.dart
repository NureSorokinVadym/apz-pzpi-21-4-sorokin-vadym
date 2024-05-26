// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) => _$ClientImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => UserExercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'exercises': instance.exercises,
    };

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      measurement: json['measurement'] as String?,
      exerciseTypeId: (json['exerciseTypeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'measurement': instance.measurement,
      'exerciseTypeId': instance.exerciseTypeId,
    };

_$UserExerciseImpl _$$UserExerciseImplFromJson(Map<String, dynamic> json) =>
    _$UserExerciseImpl(
      id: (json['id'] as num).toInt(),
      exercise: json['exercise'] == null
          ? null
          : Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? const Duration()
          : Duration(microseconds: (json['duration'] as num).toInt()),
      number: (json['number'] as num?)?.toInt() ?? 0,
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      pulse: (json['pulse'] as num?)?.toInt() ?? 0,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$UserExerciseImplToJson(_$UserExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exercise': instance.exercise,
      'duration': instance.duration.inMicroseconds,
      'number': instance.number,
      'weight': instance.weight,
      'pulse': instance.pulse,
      'date': instance.date,
    };
