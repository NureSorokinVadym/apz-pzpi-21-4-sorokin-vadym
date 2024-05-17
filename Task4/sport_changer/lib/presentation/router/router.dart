import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_changer/presentation/screens/main_screen.dart';
import 'package:sport_changer/application/controllers/auth.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerState');
  final shellKey = GlobalKey<NavigatorState>(debugLabel: 'shellState');
  final isAuth = ValueNotifier(const AsyncValue.data(false));
  ref
    ..listen(
        authInfoControlerProvider
            .select((value) => value.whenData((value) => value?.token)),
        (state, nextValue) {
      isAuth.value = AsyncValue.data(nextValue.when(
          data: (value) => value != null,
          loading: () => false,
          error: (_, __) => false));
    })
    ..onDispose(isAuth.dispose);

  final _router = GoRouter(
    navigatorKey: routerKey,
    initialLocation: '/',
    refreshListenable: isAuth,
    redirect: (context, state) {
      final authValue = isAuth.value.requireValue;
      final isLogin = state.fullPath == "/login";

      if (authValue && isLogin) return "/";
      if (!authValue && !isLogin) return "/login";
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),
      ShellRoute(
          navigatorKey: shellKey,
          routes: [
            GoRoute(
                path: "/exercise",
                name: "exercise",
                builder: (context, state) => const ExercisesScreen()),
            GoRoute(
                path: "/setting",
                name: "setting",
                builder: (context, state) => const SettingScreen()),
          ],
          builder: (context, state, child) => ShellScreen(child: child)),
      GoRoute(
        path: '/login',
        name: 'authorization',
        builder: (context, state) => const AuthScreen(),
      )
    ],
  );

  ref.onDispose(_router.dispose);

  return _router;
}
