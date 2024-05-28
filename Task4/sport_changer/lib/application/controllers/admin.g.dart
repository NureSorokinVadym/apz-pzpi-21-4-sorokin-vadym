// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSpecificationsHash() => r'd0a86f51bd38e7a789b50e3c7d925af17d5572b6';

/// See also [getSpecifications].
@ProviderFor(getSpecifications)
final getSpecificationsProvider =
    AutoDisposeFutureProvider<Map<int, String>>.internal(
  getSpecifications,
  name: r'getSpecificationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSpecificationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSpecificationsRef = AutoDisposeFutureProviderRef<Map<int, String>>;
String _$createPersonalHash() => r'de13cc16951b31241abc7e7b60e5a144e00e9172';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [createPersonal].
@ProviderFor(createPersonal)
const createPersonalProvider = CreatePersonalFamily();

/// See also [createPersonal].
class CreatePersonalFamily extends Family<AsyncValue<int>> {
  /// See also [createPersonal].
  const CreatePersonalFamily();

  /// See also [createPersonal].
  CreatePersonalProvider call({
    required Personal personal,
  }) {
    return CreatePersonalProvider(
      personal: personal,
    );
  }

  @override
  CreatePersonalProvider getProviderOverride(
    covariant CreatePersonalProvider provider,
  ) {
    return call(
      personal: provider.personal,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createPersonalProvider';
}

/// See also [createPersonal].
class CreatePersonalProvider extends AutoDisposeFutureProvider<int> {
  /// See also [createPersonal].
  CreatePersonalProvider({
    required Personal personal,
  }) : this._internal(
          (ref) => createPersonal(
            ref as CreatePersonalRef,
            personal: personal,
          ),
          from: createPersonalProvider,
          name: r'createPersonalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createPersonalHash,
          dependencies: CreatePersonalFamily._dependencies,
          allTransitiveDependencies:
              CreatePersonalFamily._allTransitiveDependencies,
          personal: personal,
        );

  CreatePersonalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.personal,
  }) : super.internal();

  final Personal personal;

  @override
  Override overrideWith(
    FutureOr<int> Function(CreatePersonalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreatePersonalProvider._internal(
        (ref) => create(ref as CreatePersonalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        personal: personal,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _CreatePersonalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreatePersonalProvider && other.personal == personal;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, personal.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreatePersonalRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `personal` of this provider.
  Personal get personal;
}

class _CreatePersonalProviderElement
    extends AutoDisposeFutureProviderElement<int> with CreatePersonalRef {
  _CreatePersonalProviderElement(super.provider);

  @override
  Personal get personal => (origin as CreatePersonalProvider).personal;
}

String _$createExerciseHash() => r'caaf9201f4c9697e3f14fc14ee39ab16d374a7d3';

/// See also [createExercise].
@ProviderFor(createExercise)
const createExerciseProvider = CreateExerciseFamily();

/// See also [createExercise].
class CreateExerciseFamily extends Family<AsyncValue<int>> {
  /// See also [createExercise].
  const CreateExerciseFamily();

  /// See also [createExercise].
  CreateExerciseProvider call({
    required Exercise E,
    String? type,
  }) {
    return CreateExerciseProvider(
      E: E,
      type: type,
    );
  }

  @override
  CreateExerciseProvider getProviderOverride(
    covariant CreateExerciseProvider provider,
  ) {
    return call(
      E: provider.E,
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createExerciseProvider';
}

/// See also [createExercise].
class CreateExerciseProvider extends AutoDisposeFutureProvider<int> {
  /// See also [createExercise].
  CreateExerciseProvider({
    required Exercise E,
    String? type,
  }) : this._internal(
          (ref) => createExercise(
            ref as CreateExerciseRef,
            E: E,
            type: type,
          ),
          from: createExerciseProvider,
          name: r'createExerciseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createExerciseHash,
          dependencies: CreateExerciseFamily._dependencies,
          allTransitiveDependencies:
              CreateExerciseFamily._allTransitiveDependencies,
          E: E,
          type: type,
        );

  CreateExerciseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.E,
    required this.type,
  }) : super.internal();

  final Exercise E;
  final String? type;

  @override
  Override overrideWith(
    FutureOr<int> Function(CreateExerciseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateExerciseProvider._internal(
        (ref) => create(ref as CreateExerciseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        E: E,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _CreateExerciseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateExerciseProvider &&
        other.E == E &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, E.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateExerciseRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `E` of this provider.
  Exercise get E;

  /// The parameter `type` of this provider.
  String? get type;
}

class _CreateExerciseProviderElement
    extends AutoDisposeFutureProviderElement<int> with CreateExerciseRef {
  _CreateExerciseProviderElement(super.provider);

  @override
  Exercise get E => (origin as CreateExerciseProvider).E;
  @override
  String? get type => (origin as CreateExerciseProvider).type;
}

String _$deleteExerciseHash() => r'8a3c1b0099d8f06dc04c6197edabc672fd5d0501';

/// See also [deleteExercise].
@ProviderFor(deleteExercise)
const deleteExerciseProvider = DeleteExerciseFamily();

/// See also [deleteExercise].
class DeleteExerciseFamily extends Family<AsyncValue<void>> {
  /// See also [deleteExercise].
  const DeleteExerciseFamily();

  /// See also [deleteExercise].
  DeleteExerciseProvider call({
    required int id,
  }) {
    return DeleteExerciseProvider(
      id: id,
    );
  }

  @override
  DeleteExerciseProvider getProviderOverride(
    covariant DeleteExerciseProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteExerciseProvider';
}

/// See also [deleteExercise].
class DeleteExerciseProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteExercise].
  DeleteExerciseProvider({
    required int id,
  }) : this._internal(
          (ref) => deleteExercise(
            ref as DeleteExerciseRef,
            id: id,
          ),
          from: deleteExerciseProvider,
          name: r'deleteExerciseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteExerciseHash,
          dependencies: DeleteExerciseFamily._dependencies,
          allTransitiveDependencies:
              DeleteExerciseFamily._allTransitiveDependencies,
          id: id,
        );

  DeleteExerciseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteExerciseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteExerciseProvider._internal(
        (ref) => create(ref as DeleteExerciseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteExerciseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteExerciseProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteExerciseRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `id` of this provider.
  int get id;
}

class _DeleteExerciseProviderElement
    extends AutoDisposeFutureProviderElement<void> with DeleteExerciseRef {
  _DeleteExerciseProviderElement(super.provider);

  @override
  int get id => (origin as DeleteExerciseProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
