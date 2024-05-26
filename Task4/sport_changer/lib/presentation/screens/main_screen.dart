import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:sport_changer/presentation/router/routes.dart';

import 'package:sport_changer/application/controllers/auth.dart';
import 'package:sport_changer/domain/auth.dart';
import './personal.dart';
import './admin.dart';

part 'main_screen.g.dart';

@hcwidget
Widget mainScreen(BuildContext context, WidgetRef ref) {
  final authInfo = ref.watch(authInfoControlerProvider);

  return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: Column(children: [
          TextButton(
              child: const Text("Go to Auth"),
              onPressed: () =>
                  ref.read(authInfoControlerProvider.notifier).deleteToken()),
          authInfo.when(
            data: (value) => value != null
                ? userInfo(context, ref, authInfo: value)
                : const Text("No data"),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text("Error: $error"),
          ),
          TextButton(
              child: const Text("Go to Exercises"),
              onPressed: () => context.go(Routes.exercise.url)),
        ])),
      ));
}

@hcwidget
Widget shellScreen(BuildContext context, WidgetRef ref,
    {required Widget child}) {
  final checkedIndex = useState(0);

  return Scaffold(
    body: child,
    bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: "Pannel",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      currentIndex: checkedIndex.value,
      onTap: (index) {
        checkedIndex.value = index;
        if (index == 0) {
          context.go(Routes.exercise.url);
        } else {
          context.go(Routes.settings.url);
        }
      },
    ),
  );
}

@hcwidget
Widget userInfo(BuildContext context, WidgetRef ref,
    {required AuthInfo authInfo}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Email: ${authInfo.email}"),
      Text("Name: ${authInfo.name}"),
      Text("Surname: ${authInfo.surname}"),
      Text("Login type: ${authInfo.loginType?.name}"),
      Text(
          "Login variants: ${authInfo.loginVariants.map((l) => l.name).join(", ")}"),
    ],
  );
}

@hcwidget
Widget settingScreen(BuildContext context, WidgetRef ref) {
  final authInfo = ref.watch(authInfoControlerProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text("Settings"),
      actions: [
        IconButton(
            onPressed: () {
              ref.read(authInfoControlerProvider.notifier).deleteToken();
            },
            icon: const Icon(Icons.logout))
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          authInfo.when(
              data: (value) => value == null
                  ? const Text("Wait")
                  : UserInfo(authInfo: value),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text("Error: $error")),
          const Gap(32),
          TextButton(
            onPressed: () {
              ref.read(authInfoControlerProvider.notifier).changeUserType();
            },
            child: const Text("Change login type"),
          )
        ],
      ),
    ),
  );
}

@hcwidget
Widget multiScreen(BuildContext context, WidgetRef ref) {
  final userType = ref.watch(getLoginTypeProvider);
  return userType == LoginType.personal
      ? const ClientViewScreen()
      : const AdminMainScreen();
}
