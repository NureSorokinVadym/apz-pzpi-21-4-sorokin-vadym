import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:go_router/go_router.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/application/controllers/personal.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sport_changer/presentation/router/routes.dart';
import 'package:sport_changer/application/controllers/auth.dart';
import 'package:sport_changer/domain/auth.dart';
import './personal.dart';
import './admin.dart';

part 'personal.g.dart';

@hcwidget
Widget clientViewScreen(BuildContext context, WidgetRef ref) {
  final clients = ref.watch(clientControllerProvider);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
      appBar: AppBar(
        title: Text(lang["personal_screen"] ?? "Personal Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(clientControllerProvider.notifier).updateClients();
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: clients.when(
            data: (clients) => ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  return ListTile(
                    title: Text(client.name ?? "No name"),
                    subtitle: Text(
                        client.surname ?? lang["no_surname"] ?? "No surname"),
                    onTap: () {
                      context.push(Routes.client.url
                          .replaceFirst(":id", client.id.toString()));
                    },
                  );
                }),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text("Error: $error")),
      ));
}

@hcwidget
Widget clientScreen(BuildContext context, WidgetRef ref, {required int id}) {
  final client = ref.watch(clientControllerProvider.select((value) => value
      .whenData((value) => value.firstWhere((element) => element.id == id))));

  ref.read(clientControllerProvider.notifier).getClientExercises(id);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
    appBar: AppBar(
      title: Text(lang["client_screen"] ?? "Client Screen"),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        context.pushNamed("addExercise", pathParameters: {"id": id.toString()});
      },
      child: const Icon(Icons.add),
    ),
    body: Center(
        child: client.when(
      data: (client) {
        final name = client.name ?? lang["no_name"] ?? "No name";
        final surname = client.surname ?? lang["no_surname"] ?? "No surname";
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text("${lang["name"] ?? "Name"}: $name"),
            Text("${lang["surname"] ?? "Surname"}: $surname"),
            ...client.exercises.where((e) => e.exercise != null).map((e) {
              final duration = e.duration == const Duration()
                  ? lang["not_started"] ?? "Not started"
                  : "${lang["duration"] ?? "Duration"}: ${e.duration}";
              final exerciseTypesName = ref.watch(
                  getExerciseTypeNameProvider(id: e.exercise!.exerciseTypeId!));
              final title = "${e.exercise!.name} [$exerciseTypesName]";
              return ListTile(
                title: ListTile(
                    title: Text(title),
                    subtitle: Text(
                        "$duration, ${lang["measurement"] ?? "Measurement"}: ${e.exercise!.measurement}")),
              );
            })
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text("Error: $error"),
    )),
  );
}

@hcwidget
Widget newExerciseScreen(BuildContext context, WidgetRef ref,
    {required int id}) {
  final exercises = ref.watch(getExercisesProvider);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
      appBar: AppBar(
        title: Text(lang["choose_exercise"] ?? "Choose Exercise"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: exercises.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text("Error: $error"),
          data: (data) => ListView.separated(
            itemCount: data.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                  child: Text(data[index].name),
                  onPressed: () {
                    ref
                        .read(clientControllerProvider.notifier)
                        .addExercise(id, data[index].id!);
                    context.pop();
                  });
            },
          ),
        )),
      ));
}
