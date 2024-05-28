import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_setting.g.dart';
part 'server_setting.freezed.dart';

@freezed
class ServerSettingModel with _$ServerSettingModel {
  const factory ServerSettingModel({
    required String url,
  }) = _ServerSetting;
}

@riverpod
class ServerSetting extends _$ServerSetting {
  @override
  ServerSettingModel build() {
    return const ServerSettingModel(url: 'http://localhost/');
  }

  changeUrl(String url) {
    state = ServerSettingModel(url: url);
  }
}
