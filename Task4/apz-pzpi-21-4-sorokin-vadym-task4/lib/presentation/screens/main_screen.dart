import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import "package:go_router/go_router.dart";
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:sport_changer/presentation/router/routes.dart';
import 'package:sport_changer/application/controllers/exporter.dart';

import 'package:sport_changer/application/controllers/auth.dart';
import 'package:sport_changer/domain/auth.dart';
import './personal.dart';
import './admin.dart';

part 'main_screen.g.dart';

@hcwidget
Widget mainScreen(BuildContext context, WidgetRef ref) {
  final authInfo = ref.watch(authInfoControlerProvider);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
      appBar: AppBar(
        title: Text(lang["main_screen"] ?? "Main Screen"),
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
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
    body: child,
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.fitness_center),
          label: lang["panel"] ?? "Panel",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: lang["settings"] ?? "Settings",
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
Widget userInfo(BuildContext context, WidgetRef ref,
    {required AuthInfo authInfo}) {
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("${lang["email"] ?? "Email"}: ${authInfo.email}"),
      Text("${lang["name"] ?? "Name"}: ${authInfo.name}"),
      Text("${lang["surname"] ?? "Surname"}: ${authInfo.surname}"),
      Text(
          "${lang["login_type"] ?? "Login type"}: ${authInfo.loginType?.name}"),
      Text(
          "${lang["login_variants"] ?? "Login variants"}: ${authInfo.loginVariants.map((l) => l.name).join(", ")}"),
    ],
  );
}

@hcwidget
Widget settingScreen(BuildContext context, WidgetRef ref) {
  final authInfo = ref.watch(authInfoControlerProvider);
  final lang = languages[ref.watch(languageSettingProvider)] ?? {};

  return Scaffold(
    appBar: AppBar(
      title: Text(lang["settings"] ?? "Settings"),
      actions: [
        IconButton(
            onPressed: () {
              ref.read(authInfoControlerProvider.notifier).deleteToken();
            },
            icon: const Icon(Icons.logout))
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          authInfo.when(
              data: (value) => value == null
                  ? const Text("Wait")
                  : UserInfo(authInfo: value),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) =>
                  Text("${lang["error"] ?? "Error"} $error")),
          const Gap(32),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
              onPressed: () {
                ref.read(authInfoControlerProvider.notifier).changeUserType();
              },
              child: Text(lang["change_user_type"] ?? "Change user type"),
            ),
            const LangChanger()
          ]),
          TextButton(
              onPressed: () {
                authInfo.when(
                    data: (value) {
                      if (value != null) {
                        exportData(value.toJson().toString());
                      }
                    },
                    loading: () {},
                    error: (error, stack) {});
              },
              child: Text(lang["export"] ?? "Export")),
        ],
      ),
    ),
  );
}

@hcwidget
Widget langChanger(BuildContext context, WidgetRef ref) {
  final lang = ref.watch(languageSettingProvider);

  return DropdownMenu(
      initialSelection: lang,
      onSelected: (value) {
        ref.read(languageSettingProvider.notifier).setLang(value ?? "en");
      },
      dropdownMenuEntries: const [
        DropdownMenuEntry(label: "English", value: "en"),
        DropdownMenuEntry(label: "Ukrainian", value: "ua")
      ],
      label: const Text("Language"));
}

@hcwidget
Widget multiScreen(BuildContext context, WidgetRef ref) {
  final userType = ref.watch(getLoginTypeProvider);
  return userType == LoginType.personal
      ? const ClientViewScreen()
      : const AdminMainScreen();
}
