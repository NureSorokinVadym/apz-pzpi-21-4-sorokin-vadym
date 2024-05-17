import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:convert';

import 'package:sport_changer/domain/auth.dart';

part 'auth.g.dart';

class Keys {
  final String key;
  const Keys(this.key);
}

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
    print("Token from shated prefs: $token");

    return null;
  }

  Future setToken(String token) async {
    await _prefs.setString(Token.key, token);
    state = AsyncValue.data(AuthInfo(token: token));
  }

  Future deleteToken() async {
    await _prefs.remove(Token.key);
    state = const AsyncValue.data(null);
  }
}

final counterProvider = StateProvider((ref) => 0);
