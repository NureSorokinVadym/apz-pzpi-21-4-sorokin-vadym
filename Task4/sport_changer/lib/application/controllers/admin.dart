import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sport_changer/domain/admin.dart';
import 'package:http/http.dart' as http;
import 'package:sport_changer/application/controllers/auth.dart';
import 'package:sport_changer/application/server_setting.dart';
import 'dart:convert';
import 'package:sport_changer/domain/personal.dart';

part 'admin.g.dart';

@riverpod
Future<Map<int, String>> getSpecifications(GetSpecificationsRef ref) async {
  final urlSetting = ref.read(serverSettingProvider);
  final response = await http
      .get(Uri.parse('${urlSetting.url}api/personal/get_specifications'));
  if (response.statusCode == 200) {
    final Map<int, String> specifications =
        jsonDecode(utf8.decode(response.bodyBytes))
            .map((key, value) => MapEntry(int.parse(key), value))
            .cast<int, String>();
    return specifications;
  }
  return {};
}

@riverpod
Future<int> createPersonal(CreatePersonalRef ref,
    {required Personal personal}) async {
  final token = ref.read(getTokenProvider);
  final client = http.Client();
  final urlSetting = ref.read(serverSettingProvider);

  final response =
      await client.post(Uri.parse('${urlSetting.url}api/admin/create_personal'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(personal.toJson()));
  if (response.statusCode == 200) {
    final id = jsonDecode(response.body)['id'];
    return id;
  }
  return -1;
}

@riverpod
Future<int> createExercise(CreateExerciseRef ref,
    {required Exercise E, String? type}) async {
  final token = ref.watch(getTokenProvider);
  final client = http.Client();
  final urlSetting = ref.read(serverSettingProvider);

  if (type != null) {
    final response = await client.post(
      Uri.parse('${urlSetting.url}api/user/create_exercise_type'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': type}),
    );

    print("Status code: ${response.statusCode}, body: ${response.body}");
    if (response.statusCode == 200) {
      final id = jsonDecode(response.body)['id'] ?? 1;
      E = E.copyWith(exerciseTypeId: id);
    }
  }

  final response = await client.post(
    Uri.parse('${urlSetting.url}api/user/create_exercise'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(E.toJson()),
  );
  if (response.statusCode == 200) {
    final id = jsonDecode(response.body)['id'] ?? -1;
    return id;
  }
  return -1;
}

@riverpod
Future<void> deleteExercise(DeleteExerciseRef ref, {required int id}) async {
  final token = ref.watch(getTokenProvider);
  final client = http.Client();
  final urlSetting = ref.read(serverSettingProvider);
  final response = await client.delete(
    Uri.parse('${urlSetting.url}api/admin/delete_exercise/$id'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode != 200) {
    print("Error: ${response.body}");
  }
}
