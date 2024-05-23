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
    return [];
  }

  downloadClient() async {
    state = const AsyncValue.loading();
    String token = ref.read(getTokenProvider);

    final response = await _client
        .get(Uri.parse('${URL}api/personal/get_clients'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      final List<Client> clients =
          jsonDecode(response.body).map((e) => Client.fromJson(e)).toList();
      state = AsyncValue.data(clients);
    } else {
      state = AsyncValue.error(response.body, StackTrace.current);
    }
  }
}
