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
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      clientScreen(
        _context,
        _ref,
        id: id,
      );
}

class NewExerciseScreen extends HookConsumerWidget {
  const NewExerciseScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      newExerciseScreen(
        _context,
        _ref,
        id: id,
      );
}
