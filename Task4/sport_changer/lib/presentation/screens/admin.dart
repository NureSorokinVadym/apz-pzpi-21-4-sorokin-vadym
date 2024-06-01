import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:go_router/go_router.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/application/controllers/personal.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sport_changer/application/controllers/admin.dart';
import 'package:sport_changer/presentation/router/routes.dart';
import 'package:sport_changer/domain/admin.dart';
import 'package:sport_changer/domain/personal.dart';
import 'package:gap/gap.dart';
import 'package:sport_changer/application/controllers/auth.dart';
part 'admin.g.dart';

@hcwidget
Widget adminMainScreen(BuildContext context, WidgetRef ref) {
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
    appBar: AppBar(
      title: Text(lang["admin_screen"] ?? "Admin Screen"),
    ),
    body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.push(Routes.adminClients.url);
            },
            child: Text(lang["client"] ?? "Clients"),
          ),
          const Gap(32),
          ElevatedButton(
            onPressed: () {
              context.push(Routes.adminExercises.url);
            },
            child: Text(lang["exercise"] ?? "Exercises"),
          ),
        ],
      ),
    ),
  );
}

@hcwidget
Widget adminClientsScreen(BuildContext context, WidgetRef ref) {
  final clients = ref.watch(clientControllerProvider);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
    appBar: AppBar(
      title: Text(lang["admin_exercise_screen"] ?? "Admin Exercise Screen"),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        ref.read(clientControllerProvider.notifier).updateClients();
      },
      child: const Icon(Icons.refresh),
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Client ID: ${client.id}"),
                        content: Column(
                          children: [
                            Text("Name: ${client.name}"),
                            Text("Surname: ${client.surname}"),
                            Text("Email: ${client.email}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                ref.read(createPersonalProvider(
                                    personal: Personal(
                                        user_id: client.id,
                                        specificationId: 1)));
                              },
                              child: const Text("Give personal")),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Give admin")),
                          TextButton(
                              onPressed: () {}, child: const Text("Delete")),
                          TextButton(
                            onPressed: context.pop,
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text("Error: $error"),
        ),
      ),
    ),
  );
}

@hcwidget
Widget adminExercisesScreen(BuildContext context, WidgetRef ref) {
  final exercisesWather = ref.watch(getExercisesProvider);
  final exerciseTypes = ref.watch(getExerciseTypesProvider);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
    appBar: AppBar(
      title: Text(lang["admin_exercise_screen"] ?? "Admin Exercise Screen"),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        context.push(Routes.adminCreateExercises.url);
      },
      child: const Icon(Icons.add),
    ),
    body: Center(
      child: exercisesWather.when(
        data: (exercises) => ListView.separated(
          shrinkWrap: true,
          itemCount: exercises.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return ListTile(
              title: Text(exercise.name),
              subtitle: Text(exercise.measurement ?? "No measurement"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Exercise ID: ${exercise.id}"),
                      content: Column(
                        children: [
                          Text("Name: ${exercise.name}"),
                          Text("Measurement: ${exercise.measurement}"),
                          exerciseTypes.when(
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stack) => Text("Error: $error"),
                            data: (data) {
                              final type = data[exercise.exerciseTypeId];
                              return Text("Type: $type");
                            },
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text("Close"),
                        ),
                        TextButton(
                          onPressed: () {
                            ref.read(deleteExerciseProvider(id: exercise.id!));
                            ref
                                .read(getExercisesProvider.notifier)
                                .updateExercises();

                            context.pop();
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text("Error: $error"),
      ),
    ),
  );
}

@hcwidget
Widget createExercise(BuildContext context, WidgetRef ref) {
  final nameController = useTextEditingController();
  final measurementController = useTextEditingController();
  final typeController = useTextEditingController();
  final exerciseTypes = ref.watch(getExerciseTypesProvider);
  final selectedId = useState<int?>(null);

  return Scaffold(
    appBar: AppBar(
      title: const Text("Create Exercise"),
    ),
    body: Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Name"),
            controller: nameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Measurement"),
            controller: measurementController,
          ),
          exerciseTypes.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text("Error: $error"),
            data: (data) => DropdownMenu<int>(
                controller: typeController,
                onSelected: (value) {
                  selectedId.value = value;
                },
                dropdownMenuEntries: data.entries.map((e) {
                  return DropdownMenuEntry(
                    value: e.key,
                    label: e.value,
                  );
                }).toList()),
          ),
          exerciseTypes.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text("Error: $error"),
            data: (data) => TextButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    measurementController.text.isEmpty ||
                    typeController.text.isEmpty) {
                  return;
                }
                if (selectedId.value != null &&
                    data.containsValue(typeController.text)) {
                  ref.read(createExerciseProvider(
                      E: Exercise(
                          name: nameController.text,
                          measurement: measurementController.text,
                          exerciseTypeId: selectedId.value)));
                } else {
                  ref.read(createExerciseProvider(
                      E: Exercise(
                          name: nameController.text,
                          measurement: measurementController.text),
                      type: typeController.text));
                }
              },
              child: const Text("Create"),
            ),
          ),
        ],
      ),
    )),
  );
}
