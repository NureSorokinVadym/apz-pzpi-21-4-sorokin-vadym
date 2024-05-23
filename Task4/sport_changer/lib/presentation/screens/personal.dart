import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/presentation/router/routes.dart';
import 'package:sport_changer/application/controllers/personal.dart';

part 'personal.g.dart';

@hcwidget
Widget clientViewScreen(BuildContext context, WidgetRef ref) {
  final clients = ref.watch(clientControllerProvider);

  return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Screen"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: clients.when(
                data: (clients) => ListView.builder(
                    itemCount: clients.length,
                    itemBuilder: (context, index) {
                      final client = clients[index];
                      return ListTile(
                        title: Text(client.name ?? "No name"),
                        subtitle: Text(client.surname ?? "No surname"),
                        onTap: () {
                          // context.go(client.id);
                        },
                      );
                    }),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text("Error: $error")),
          )));
}
