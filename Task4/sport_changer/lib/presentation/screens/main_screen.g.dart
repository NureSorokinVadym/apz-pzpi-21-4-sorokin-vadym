// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

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

class ExercisesScreen extends HookConsumerWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      exercisesScreen(
        _context,
        _ref,
      );
}

class NewExerciseScreen extends HookConsumerWidget {
  const NewExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      newExerciseScreen(
        _context,
        _ref,
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