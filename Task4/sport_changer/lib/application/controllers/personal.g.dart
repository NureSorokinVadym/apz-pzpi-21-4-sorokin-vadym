// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getExerciseTypesHash() => r'428adb2763b248f535bcac9fb7bee28fedb415e7';

/// See also [getExerciseTypes].
@ProviderFor(getExerciseTypes)
final getExerciseTypesProvider =
    AutoDisposeFutureProvider<Map<int, String>>.internal(
  getExerciseTypes,
  name: r'getExerciseTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getExerciseTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetExerciseTypesRef = AutoDisposeFutureProviderRef<Map<int, String>>;
String _$getExerciseTypeNameHash() =>
    r'e3fa9e27f0099708d3ec6c9eceefe3ccb4cfaa7e';

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

/// See also [getExerciseTypeName].
@ProviderFor(getExerciseTypeName)
const getExerciseTypeNameProvider = GetExerciseTypeNameFamily();

/// See also [getExerciseTypeName].
class GetExerciseTypeNameFamily extends Family<String> {
  /// See also [getExerciseTypeName].
  const GetExerciseTypeNameFamily();

  /// See also [getExerciseTypeName].
  GetExerciseTypeNameProvider call({
    required int id,
  }) {
    return GetExerciseTypeNameProvider(
      id: id,
    );
  }

  @override
  GetExerciseTypeNameProvider getProviderOverride(
    covariant GetExerciseTypeNameProvider provider,
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
  String? get name => r'getExerciseTypeNameProvider';
}

/// See also [getExerciseTypeName].
class GetExerciseTypeNameProvider extends AutoDisposeProvider<String> {
  /// See also [getExerciseTypeName].
  GetExerciseTypeNameProvider({
    required int id,
  }) : this._internal(
          (ref) => getExerciseTypeName(
            ref as GetExerciseTypeNameRef,
            id: id,
          ),
          from: getExerciseTypeNameProvider,
          name: r'getExerciseTypeNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getExerciseTypeNameHash,
          dependencies: GetExerciseTypeNameFamily._dependencies,
          allTransitiveDependencies:
              GetExerciseTypeNameFamily._allTransitiveDependencies,
          id: id,
        );

  GetExerciseTypeNameProvider._internal(
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
    String Function(GetExerciseTypeNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetExerciseTypeNameProvider._internal(
        (ref) => create(ref as GetExerciseTypeNameRef),
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
  AutoDisposeProviderElement<String> createElement() {
    return _GetExerciseTypeNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetExerciseTypeNameProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetExerciseTypeNameRef on AutoDisposeProviderRef<String> {
  /// The parameter `id` of this provider.
  int get id;
}

class _GetExerciseTypeNameProviderElement
    extends AutoDisposeProviderElement<String> with GetExerciseTypeNameRef {
  _GetExerciseTypeNameProviderElement(super.provider);

  @override
  int get id => (origin as GetExerciseTypeNameProvider).id;
}

String _$clientControllerHash() => r'bab257a7d2a0826ee114517c249cf946fe919595';

/// See also [ClientController].
@ProviderFor(ClientController)
final clientControllerProvider =
    AutoDisposeAsyncNotifierProvider<ClientController, List<Client>>.internal(
  ClientController.new,
  name: r'clientControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clientControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClientController = AutoDisposeAsyncNotifier<List<Client>>;
String _$getExercisesHash() => r'2dbf0adecb78614697b72ddcf9d21b739793c5f5';

/// See also [GetExercises].
@ProviderFor(GetExercises)
final getExercisesProvider =
    AutoDisposeAsyncNotifierProvider<GetExercises, List<Exercise>>.internal(
  GetExercises.new,
  name: r'getExercisesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getExercisesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetExercises = AutoDisposeAsyncNotifier<List<Exercise>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
