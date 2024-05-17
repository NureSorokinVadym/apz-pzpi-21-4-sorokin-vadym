import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:go_router/go_router.dart";

import 'package:sport_changer/application/controllers/auth.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Main Screen $counter"),
            ElevatedButton(
              onPressed: () {
                ref.read(authInfoControlerProvider.notifier).setToken("token");
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends ConsumerWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Second Screen $counter"),
            ElevatedButton(
              onPressed: () {
                context.push("/third");
              },
              child: const Text("Go to Counter change screen"),
            ),
            TextButton(
              onPressed: () {
                ref.read(authInfoControlerProvider.notifier).deleteToken();
              },
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends ConsumerWidget {
  ThirdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Third Screen"),
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Counter Screen"),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state++;
              },
              child: Text("Counter (click me): $counter"),
            ),
          ],
        ),
      ),
    );
  }
}
