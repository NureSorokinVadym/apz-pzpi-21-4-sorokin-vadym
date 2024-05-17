import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_changer/presentation/screens/main_screen.dart';
import 'package:sport_changer/application/controllers/auth.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerState');
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
      print("Hello from update with state: $state\n and nextValue: $nextValue");
      print("isAuth: ${isAuth.value}");
      print("isAuth: ${isAuth.value.requireValue}");
    })
    ..onDispose(isAuth.dispose);

  final _router = GoRouter(
    navigatorKey: routerKey,
    initialLocation: '/',
    refreshListenable: isAuth,
    redirect: (context, state) {
      print("State: ${state.fullPath}");
      if (isAuth.value.requireValue && state.fullPath == "/") {
        return "/second";
      }
      if (!isAuth.value.requireValue && state.fullPath != "/") {
        return "/";
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/second',
        builder: (context, state) => const SecondScreen(),
      ),
      GoRoute(
        path: '/third',
        builder: (context, state) => ThirdScreen(),
      ),
    ],
  );

  ref.onDispose(_router.dispose);

  return _router;
}
