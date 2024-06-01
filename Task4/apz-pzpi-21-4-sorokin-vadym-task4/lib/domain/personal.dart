import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal.freezed.dart';
part 'personal.g.dart';

@freezed
class Client with _$Client {
  const factory Client({
    required int id,
    String? name,
    String? surname,
    String? email,
    @Default([]) List<UserExercise> exercises,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}

@freezed
class Exercise with _$Exercise {
  const factory Exercise(
      {int? id,
      required String name,
      String? measurement,
      int? exerciseTypeId}) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  factory Exercise.nullValue() =>
      const Exercise(id: 0, name: 'null', measurement: 'null');
}

@freezed
class UserExercise with _$UserExercise {
  const factory UserExercise(
      {required int id,
      Exercise? exercise,
      @Default(Duration()) Duration duration,
      @Default(0) int number,
      @Default(0) int weight,
      @Default(0) int pulse,
      required String date}) = _UserExercise;

  factory UserExercise.fromJson(Map<String, dynamic> json) =>
      _$UserExerciseFromJson(json);
}
