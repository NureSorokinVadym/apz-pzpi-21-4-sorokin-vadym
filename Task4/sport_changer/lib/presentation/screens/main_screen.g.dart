// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class MainScreen extends HookConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      mainScreen(
        _context,
        _ref,
      );
}

class ShellScreen extends HookConsumerWidget {
  const ShellScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      shellScreen(
        _context,
        _ref,
        child: child,
      );
}

class UserInfo extends HookConsumerWidget {
  const UserInfo({
    Key? key,
    required this.authInfo,
  }) : super(key: key);

  final AuthInfo authInfo;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      userInfo(
        _context,
        _ref,
        authInfo: authInfo,
      );
}

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      settingScreen(
        _context,
        _ref,
      );
}

class LangChanger extends HookConsumerWidget {
  const LangChanger({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      langChanger(
        _context,
        _ref,
      );
}

class MultiScreen extends HookConsumerWidget {
  const MultiScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      multiScreen(
        _context,
        _ref,
      );
}
