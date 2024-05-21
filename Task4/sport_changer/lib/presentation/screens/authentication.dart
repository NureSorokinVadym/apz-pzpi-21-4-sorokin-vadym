import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/presentation/router/routes.dart';

import 'package:sport_changer/application/controllers/auth.dart';

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(Routes.login.url),
        child: const Icon(Icons.add),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(Routes.sighup.url),
        child: const Icon(Icons.minimize),
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
            ],
          ),
        ),
      ));
}
