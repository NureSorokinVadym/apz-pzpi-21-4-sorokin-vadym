import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/presentation/router/routes.dart';

import 'package:sport_changer/application/controllers/auth.dart';
import 'package:sport_changer/application/server_setting.dart';

part 'authentication.g.dart';

@hcwidget
Widget sighUpScreen(BuildContext context, WidgetRef ref) {
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();
  final nameController = useTextEditingController();
  final surnameController = useTextEditingController();

  return Scaffold(
      appBar: AppBar(
        title: const Text("Sigh up"),
        actions: [
          IconButton(
              onPressed: () => context.go(Routes.login.url),
              icon: const Icon(Icons.login))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: surnameController,
                decoration: const InputDecoration(labelText: "Surname"),
              ),
              TextButton(
                  child: const Text("Log up"),
                  onPressed: () => ref
                      .read(authInfoControlerProvider.notifier)
                      .requestLogup(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          surnameController.text)),
              const Spacer(),
              const ChangeUrlSetting(),
            ],
          ),
        ),
      ));
}

@hcwidget
Widget logInScreen(BuildContext context, WidgetRef ref) {
  final emailController = useTextEditingController();
  final passwordController = useTextEditingController();

  return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: [
          IconButton(
              onPressed: () => context.go(Routes.sighup.url),
              icon: const Icon(Icons.app_registration))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              TextButton(
                  child: const Text("Log in"),
                  onPressed: () => ref
                      .read(authInfoControlerProvider.notifier)
                      .requestLogin(
                          emailController.text, passwordController.text)),
              const Spacer(),
              const ChangeUrlSetting()
            ],
          ),
        ),
      ));
}

@hcwidget
Widget changeUrlSetting(BuildContext context, WidgetRef ref) {
  final urlController = useTextEditingController();
  urlController.text = ref.watch(serverSettingProvider).url;

  return Column(
    children: [
      TextField(
        controller: urlController,
        decoration: const InputDecoration(labelText: "Url"),
      ),
      TextButton(
          child: const Text("Change"),
          onPressed: () => ref
              .read(serverSettingProvider.notifier)
              .changeUrl(urlController.text)),
    ],
  );
}
