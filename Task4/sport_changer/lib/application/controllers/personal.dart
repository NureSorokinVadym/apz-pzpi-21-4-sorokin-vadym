import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sport_changer/domain/personal.dart';
import 'package:http/http.dart' as http;
import 'package:sport_changer/application/controllers/auth.dart';
import 'dart:convert';

part 'personal.g.dart';

const URL = "http://localhost/";

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

    final response = await _client
        .get(Uri.parse('${URL}api/personal/get_clients'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print(response.body);

    if (response.statusCode == 200) {
      final List<Client> clients =
          jsonDecode(response.body).map((e) => Client.fromJson(e)).toList();
      return clients;
    }
    return [];
  }

  getClientExercises(int id) async {
    final data = state.value;
    if (data == null) return;

    final token = ref.read(getTokenProvider);

    final response = await _client
        .get(Uri.parse("${URL}api/personal/get_exercises/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final List<UserExercise> exercises = jsonDecode(response.body)
          .map((e) => UserExercise.fromJson(e))
          .toList();
      state = AsyncValue.data(data
          .map((e) => e.id == id ? e.copyWith(exercises: exercises) : e)
          .toList());
      return exercises;
    }
  }
}
