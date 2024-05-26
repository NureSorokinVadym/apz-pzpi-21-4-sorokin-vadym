import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:go_router/go_router.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/application/controllers/personal.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sport_changer/presentation/router/routes.dart';

part 'personal.g.dart';

@hcwidget
Widget clientViewScreen(BuildContext context, WidgetRef ref) {
  final clients = ref.watch(clientControllerProvider);

  return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Screen"),
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
                    subtitle: Text(client.surname ?? "No surname"),
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

  return Scaffold(
    appBar: AppBar(
      title: const Text("Client Screen"),
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
        final name = client.name ?? "No name";
        final surname = client.surname ?? "No surname";
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text("Name: $name"),
            Text("Surname: $surname"),
            ...client.exercises.where((e) => e.exercise != null).map((e) {
              final duration = e.duration == const Duration()
                  ? "Not started"
                  : "Duration: ${e.duration}";
              final exerciseTypesName = ref.watch(
                  getExerciseTypeNameProvider(id: e.exercise!.exerciseTypeId!));
              final title = "${e.exercise!.name} [$exerciseTypesName]";
              return ListTile(
                title: ListTile(
                    title: Text(title),
                    subtitle: Text(
                        "$duration, Measurement: ${e.exercise!.measurement}")),
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

  return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Exercise"),
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
