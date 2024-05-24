// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ClientViewScreen extends HookConsumerWidget {
  const ClientViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      clientViewScreen(
        _context,
        _ref,
      );
}

class ClientScreen extends HookConsumerWidget {
  const ClientScreen({
    Key? key,
    required this.client,
  }) : super(key: key);

  final Client client;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      clientScreen(
        _context,
        _ref,
        client: client,
      );
}

class NewExerciseScreen extends HookConsumerWidget {
  const NewExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      newExerciseScreen(
        _context,
        _ref,
      );
}
