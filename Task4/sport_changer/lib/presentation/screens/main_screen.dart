import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'package:sport_changer/application/controllers/auth.dart';
import 'package:sport_changer/domain/auth.dart';

part 'main_screen.g.dart';

@hcwidget
Widget userInfo(BuildContext context, WidgetRef ref,
    {required AuthInfo authInfo}) {
  return Column(
    children: [
      Text("Email: ${authInfo.email}"),
      Text("Name: ${authInfo.name}"),
      Text("Surname: ${authInfo.surname}"),
    ],
  );
}

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
              onPressed: () => context.go("/exercise")),
        ])),
      ));
}

@hcwidget
Widget authScreen(BuildContext context, WidgetRef ref) {
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();

  final label = useState("");

  return Scaffold(
      appBar: AppBar(
        title: Text("Auth Screen ${label.value}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                onChanged: (value) => label.value = value,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              TextButton(
                  child: const Text("Save token"),
                  onPressed: () => ref
                      .read(authInfoControlerProvider.notifier)
                      .requestLogin(
                          emailController.text, passwordController.text)),
            ],
          ),
        ),
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
          label: "Exercises",
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
          context.go("/exercise");
        } else {
          context.go("/setting");
        }
      },
    ),
  );
}

@hcwidget
Widget exercisesScreen(BuildContext context, WidgetRef ref) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Exercises Screen"),
    ),
    body: Center(
      child: Text("Exercises"),
    ),
  );
}

@hcwidget
Widget settingScreen(BuildContext context, WidgetRef ref) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Settings Screen"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            TextButton(
                child: const Text("Go to Start"),
                onPressed: () => context.go("/")),
          ],
        ),
      ),
    ),
  );
}
