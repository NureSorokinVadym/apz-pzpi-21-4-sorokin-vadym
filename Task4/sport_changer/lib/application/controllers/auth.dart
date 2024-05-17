import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sport_changer/domain/auth.dart';

part 'auth.g.dart';

class Keys {
  final String key;
  const Keys(this.key);
}

const URL = "http://localhost/";

const Token = Keys('token');

@riverpod
class AuthInfoControler extends _$AuthInfoControler {
  late SharedPreferences _prefs;
  late http.Client _client;

  @override
  Future<AuthInfo?> build() async {
    _prefs = await SharedPreferences.getInstance();
    _client = http.Client();

    final token = _prefs.getString(Token.key);
    if (token != null) {
      return _getUserInfo(token);
    }
    return null;
  }

  Future requestLogin(String email, String password) async {
    state = const AsyncValue.loading();
    final response = await _client.post(
      Uri.parse('${URL}api/auth/log_in'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'] as String;
      await setToken(token);
    }
  }

  Future setAuthInfo(AuthInfo authInfo) async {
    await _prefs.setString(Token.key, authInfo.token);
    state = AsyncValue.data(authInfo);
  }

  Future setToken(String token) async {
    await _prefs.setString(Token.key, token);
    state = AsyncValue.data(await _getUserInfo(token));
  }

  Future deleteToken() async {
    await _prefs.remove(Token.key);
    state = const AsyncValue.data(null);
  }

  Future<AuthInfo> _getUserInfo(String token) async {
    final response = await _client.get(
      Uri.parse('${URL}api/auth/user_info'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['token'] = token;
      return AuthInfo.fromJson(data);
    }
    return AuthInfo(token: token);
  }
}
