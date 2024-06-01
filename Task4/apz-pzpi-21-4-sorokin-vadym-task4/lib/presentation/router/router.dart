import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_changer/presentation/screens/main_screen.dart';
import 'package:sport_changer/presentation/screens/authentication.dart';
import 'package:sport_changer/presentation/screens/personal.dart';
import 'package:sport_changer/presentation/screens/admin.dart';
import 'package:sport_changer/application/controllers/auth.dart';
import './routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  // Ключі для навігаторів
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerState');
  final shellKey = GlobalKey<NavigatorState>(debugLabel: 'shellState');
  final isAuth = ValueNotifier(const AsyncValue.data(false));
  // Прослуховування зміни токена
  ref
    ..listen(getTokenProvider, (state, nextValue) {
      isAuth.value = AsyncValue.data(nextValue != '');
    })
    ..onDispose(isAuth.dispose);

  final router = GoRouter(
    navigatorKey: routerKey,
    initialLocation: Routes.login.url,
    refreshListenable: isAuth,
    // Налаштування переадресації у разі авторизації
    redirect: (context, state) {
      final authValue = isAuth.value.requireValue;
      final isLogin = state.fullPath?.startsWith("/auth") ?? false;
      final nextRouteIsAuth = state.matchedLocation.startsWith("/auth");

      if (authValue && isLogin) return Routes.exercise.url;
      if (!authValue && !isLogin) {
        return nextRouteIsAuth ? null : Routes.login.url;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.addExercise.url,
        name: Routes.addExercise.name,
        builder: (context, state) =>
            NewExerciseScreen(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: Routes.client.url,
        name: Routes.client.name,
        builder: (context, state) {
          final id = state.pathParameters['id'];
          if (id == null) return const Text("Error");
          return ClientScreen(id: int.parse(id));
        },
      ),
      // Створення екрану з вкладками
      ShellRoute(
          navigatorKey: shellKey,
          routes: [
            GoRoute(
                path: Routes.exercise.url,
                name: Routes.exercise.name,
                builder: (context, state) => const MultiScreen()),
            GoRoute(
                path: Routes.settings.url,
                name: Routes.settings.name,
                builder: (context, state) => const SettingScreen()),
          ],
          builder: (context, state, child) => ShellScreen(child: child)),
      GoRoute(
        path: Routes.login.url,
        name: Routes.login.name,
        builder: (context, state) => const LogInScreen(),
      ),
      GoRoute(
        path: Routes.sighup.url,
        name: Routes.sighup.name,
        builder: (context, state) => const SighUpScreen(),
      ),
      GoRoute(
          path: Routes.adminClients.url,
          name: Routes.adminClients.name,
          builder: (context, state) => const AdminClientsScreen()),
      GoRoute(
        path: Routes.adminExercises.url,
        name: Routes.adminExercises.name,
        builder: (context, state) => const AdminExercisesScreen(),
      ),
      GoRoute(
        path: Routes.adminCreateExercises.url,
        name: Routes.adminCreateExercises.name,
        builder: (context, state) => const CreateExercise(),
      )
    ],
  );
  // Очищення підписок
  ref.onDispose(router.dispose);

  return router;
}
