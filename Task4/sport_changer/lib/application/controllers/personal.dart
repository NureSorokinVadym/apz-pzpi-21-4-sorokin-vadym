import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sport_changer/domain/personal.dart';
import 'package:http/http.dart' as http;
import 'package:sport_changer/application/controllers/auth.dart';
import 'dart:convert';

import 'package:sport_changer/application/server_setting.dart';
part 'personal.g.dart';

@riverpod
class ClientController extends _$ClientController {
  late http.Client _client;

  @override
  Future<List<Client>> build() async {
    _client = http.Client();
    return downloadClient();
  }

  updateClients() async {
    state = const AsyncValue.loading();
    final clients = await downloadClient();
    state = AsyncValue.data(clients);
  }

  Future<List<Client>> downloadClient() async {
    String token = ref.read(getTokenProvider);
    final urlSetting = ref.read(serverSettingProvider);

    final response = await _client
        .get(Uri.parse('${urlSetting.url}api/personal/get_clients'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final List<Client> clients = jsonDecode(utf8.decode(response.bodyBytes))
          .map((e) => Client.fromJson(e))
          .toList()
          .cast<Client>();
      return clients;
    }
    return [];
  }

  getClientExercises(int id) async {
    final data = state.value;
    if (data == null) return;

    final token = ref.read(getTokenProvider);

    final urlSetting = ref.read(serverSettingProvider);
    final response = await _client.get(
        Uri.parse("${urlSetting.url}api/personal/get_exercises/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      final List<UserExercise> exercises =
          jsonDecode(utf8.decode(response.bodyBytes))
              .map((e) => UserExercise.fromJson(e))
              .toList()
              .cast<UserExercise>();
      exercises.sort((a, b) => a.id.compareTo(b.id));
      state = AsyncValue.data(data
          .map((e) => e.id == id ? e.copyWith(exercises: exercises) : e)
          .toList()
          .cast<Client>());

      return exercises;
    }
  }

  addExercise(int user_id, int exercise_id) async {
    final token = ref.read(getTokenProvider);

    final urlSetting = ref.read(serverSettingProvider);
    final response = await _client.post(
        Uri.parse("${urlSetting.url}api/personal/add_exercise"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"user_id": user_id, "exercise_id": exercise_id}));

    if (response.statusCode == 200) {
      getClientExercises(user_id);
    }
  }
}

@riverpod
class GetExercises extends _$GetExercises {
  late http.Client _client;

  @override
  Future<List<Exercise>> build() async {
    _client = http.Client();
    final List<Exercise> response = await getExercises();
    return response;
  }

  updateExercises() async {
    state = const AsyncValue.loading();
    final exercises = await getExercises();
    state = AsyncValue.data(exercises);
  }

  Future<List<Exercise>> getExercises() async {
    final token = ref.read(getTokenProvider);

    final urlSetting = ref.read(serverSettingProvider);
    final response = await _client.get(
        Uri.parse("${urlSetting.url}api/personal/get_exercises_list"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      final List<Exercise> exercises =
          jsonDecode(utf8.decode(response.bodyBytes))
              .map((e) => Exercise.fromJson(e))
              .toList()
              .cast<Exercise>();
      return exercises;
    }
    return [];
  }
}

@riverpod
Future<Map<int, String>> getExerciseTypes(GetExerciseTypesRef ref) async {
  final client = http.Client();
  final token = ref.read(getTokenProvider);

  final urlSetting = ref.read(serverSettingProvider);
  final response = await client.get(
      Uri.parse("${urlSetting.url}api/personal/get_exercise_types"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

  if (response.statusCode == 200) {
    final Map<int, String> exerciseTypes =
        jsonDecode(utf8.decode(response.bodyBytes))
            .map((key, value) => MapEntry(int.parse(key), value))
            .cast<int, String>();
    return exerciseTypes;
  }
  return {};
}

@riverpod
String getExerciseTypeName(GetExerciseTypeNameRef ref, {required int id}) {
  final exerciseTypes = ref.watch(getExerciseTypesProvider);
  return exerciseTypes.when(
      data: (value) => value[id] ?? "",
      loading: () => "",
      error: (error, stack) => "");
}
