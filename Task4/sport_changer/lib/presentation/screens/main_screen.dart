import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:sport_changer/presentation/router/routes.dart';

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
          context.go(Routes.exercise.url);
        } else {
          context.go(Routes.settings.url);
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
    floatingActionButton: FloatingActionButton(
      onPressed: () => context.push("/exercise/add"),
      child: const Icon(Icons.add),
    ),
  );
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
                onPressed: () {
                  ref.read(authInfoControlerProvider.notifier).deleteToken();
                }),
          ],
        ),
      ),
    ),
  );
}
