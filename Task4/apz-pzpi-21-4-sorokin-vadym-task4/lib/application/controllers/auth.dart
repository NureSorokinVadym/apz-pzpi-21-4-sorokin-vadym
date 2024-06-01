import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sport_changer/application/server_setting.dart';
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
    if (token != null) {
      return _getUserInfo(token);
    }
    return null;
  }

  Future requestLogin(String email, String password) async {
    final urlSetting = ref.read(serverSettingProvider);

    state = const AsyncValue.loading();
    final response = await _client.post(
      Uri.parse('${urlSetting.url}api/auth/log_in'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body);
      await setToken(token);
    }
  }

  Future requestLogup(
      String email, String password, String name, String surname) async {
    state = const AsyncValue.loading();
    final urlSetting = ref.read(serverSettingProvider);
    final response = await _client.post(
      Uri.parse('${urlSetting.url}api/auth/log_up'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'surname': surname,
      }),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body);
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

  changeUserType() async {
    final authInfo = state.when(
        data: (authInfo) => authInfo,
        loading: () => null,
        error: (error, _) => null);
    if (authInfo == null || authInfo.loginVariants.isEmpty) {
      return;
    }
    final index = authInfo.loginVariants.indexOf(authInfo.loginType!);
    final newIndex = (index + 1) % authInfo.loginVariants.length;
    state = AsyncValue.data(
        authInfo.copyWith(loginType: authInfo.loginVariants[newIndex]));
  }

  Future<AuthInfo> _getUserInfo(String token) async {
    final urlSetting = ref.read(serverSettingProvider);
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final response = await _client.get(
        Uri.parse('${urlSetting.url}api/auth/user_info'),
        headers: headers);

    final userTypesResp = await _client.get(
        Uri.parse('${urlSetting.url}api/auth/user_types'),
        headers: headers);

    if (response.statusCode == 200 && userTypesResp.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['token'] = token;
      if (userTypesResp.body.isEmpty) {
        return AuthInfo.fromJson(data);
      }
      data['loginVariants'] = jsonDecode(userTypesResp.body);
      data['loginType'] = data['loginVariants'][0];
      return AuthInfo.fromJson(data);
    }
    return AuthInfo(token: token);
  }
}

@riverpod
String getToken(GetTokenRef ref) {
  return ref.watch(authInfoControlerProvider).when(
        data: (authInfo) => authInfo?.token ?? '',
        loading: () => '',
        error: (error, _) => '',
      );
}

@riverpod
LoginType? getLoginType(GetLoginTypeRef ref) {
  return ref.watch(authInfoControlerProvider).when(
      data: (authInfo) => authInfo?.loginType,
      loading: () => null,
      error: (error, _) => null);
}

@riverpod
class LanguageSetting extends _$LanguageSetting {
  @override
  String build() {
    return 'en';
  }

  setLang(String lang) {
    state = lang;
  }
}

const languages = {
  "en": {
    "email": "Email",
    "password": "Password",
    "name": "Name",
    "surname": "Surname",
    "login_type": "Login type",
    "login_variants": "Login variants",
    "log_in": "Log in",
    "log_up": "Log up",
    "settings": "Settings",
    "logout": "Logout",
    "wait": "Wait",
    "error": "Error",
    "change_user_type": "Change user type",
    "personal_screen": "Personal screen",
    "main_screen": "Main screen",
    "panel": "Panel",
    "no_surname": "No surname",
    "client_screen": "Client screen",
    "not_started": "Not started",
    "duration": "Duration",
    "measurement": "Measurement",
    "choose_exercise": "Choose Exercise",
    "client": "Client",
    "exercise": "Exercise",
    "admin_screen": "Admin screen",
    "admin_exercise_screen": "Admin exercise screen",
    "export": "Export",
  },
  "ua": {
    "email": "Електронна пошта",
    "password": "Пароль",
    "name": "Ім'я",
    "surname": "Прізвище",
    "login_type": "Тип входу",
    "login_variants": "Варіанти входу",
    "log_in": "Увійти",
    "log_up": "Зареєструватися",
    "settings": "Налаштування",
    "logout": "Вийти",
    "wait": "Зачекайте",
    "error": "Помилка",
    "change_user_type": "Змінити тип користувача",
    "personal_screen": "Особистий екран",
    "main_screen": "Головний екран",
    "panel": "Панель",
    "no_surname": "Немає прізвища",
    "client_screen": "Екран клієнта",
    "not_started": "Не розпочато",
    "duration": "Тривалість",
    "measurement": "Вимірювання",
    "choose_exercise": "Виберіть вправу",
    "client": "Клієнт",
    "exercise": "Вправа",
    "admin_screen": "Екран адміністратора",
    "admin_exercise_screen": "Екран адміністратора вправ",
    "export": "Експорт",
  },
};
