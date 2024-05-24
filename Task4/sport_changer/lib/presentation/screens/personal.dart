import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:go_router/go_router.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/application/controllers/personal.dart';
import 'package:sport_changer/domain/personal.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

@hcwidget
Widget clientScreen(BuildContext context, WidgetRef ref,
    {required Client client}) {
  useEffect(() {
    ref.read(clientControllerProvider.notifier).getClientExercises(client.id);
    return null;
  }, []);

  return Scaffold(
      appBar: AppBar(
        title: const Text("Client Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed("addExercise");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text("Name: ${client.name}"),
              Text("Surname: ${client.surname}"),
              Text("Email: ${client.email}"),
              Text("Exercises total number: ${client.exercises.length}"),
              ListView.builder(
                itemCount: client.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = client.exercises[index];
                  return ListTile(
                    title: Text(exercise.exercise?.name ?? "No name"),
                    subtitle: Text("Date: ${exercise.date}"),
                    onTap: () {
                      // context.go(exercise.id);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ));
}

@hcwidget
Widget newExerciseScreen(BuildContext context, WidgetRef ref) {
  final tabController = useTabController(initialLength: 10);

  return Scaffold(
    appBar: AppBar(
      title: const Text("Choose Exercise"),
      bottom: TabBar(
        isScrollable: true,
        controller: tabController,
        tabs: const [
          Tab(text: "Tab 1"),
          Tab(text: "Tab 2"),
          Tab(text: "Tab 3"),
          Tab(text: "Tab 4"),
          Tab(text: "Tab 5"),
          Tab(text: "Tab 6"),
          Tab(text: "Tab 7"),
          Tab(text: "Tab 8"),
          Tab(text: "Tab 9"),
          Tab(text: "Tab 10"),
        ],
      ),
    ),
    body: TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text("Tab 1")),
        Center(child: Text("Tab 2")),
        Center(child: Text("Tab 3")),
        Center(child: Text("Tab 4")),
        Center(child: Text("Tab 5")),
        Center(child: Text("Tab 6")),
        Center(child: Text("Tab 7")),
        Center(child: Text("Tab 8")),
        Center(child: Text("Tab 9")),
        Center(child: Text("Tab 10")),
      ],
    ),
  );
}
