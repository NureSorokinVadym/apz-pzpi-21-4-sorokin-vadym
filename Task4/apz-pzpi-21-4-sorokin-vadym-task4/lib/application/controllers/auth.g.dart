// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTokenHash() => r'f2c040600385448cc0aedf6de4498f76ab5f4665';

/// See also [getToken].
@ProviderFor(getToken)
final getTokenProvider = AutoDisposeProvider<String>.internal(
  getToken,
  name: r'getTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetTokenRef = AutoDisposeProviderRef<String>;
String _$getLoginTypeHash() => r'2ea59535d378210ce4ddc576da07a83400856f57';

/// See also [getLoginType].
@ProviderFor(getLoginType)
final getLoginTypeProvider = AutoDisposeProvider<LoginType?>.internal(
  getLoginType,
  name: r'getLoginTypeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getLoginTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLoginTypeRef = AutoDisposeProviderRef<LoginType?>;
String _$authInfoControlerHash() => r'e0f7c08e175e1df7b3f57be38e42c037bc2c7255';

/// See also [AuthInfoControler].
@ProviderFor(AuthInfoControler)
final authInfoControlerProvider =
    AutoDisposeAsyncNotifierProvider<AuthInfoControler, AuthInfo?>.internal(
  AuthInfoControler.new,
  name: r'authInfoControlerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authInfoControlerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthInfoControler = AutoDisposeAsyncNotifier<AuthInfo?>;
String _$languageSettingHash() => r'08745e7c723bab8561d0d59a5fc72a063314862d';

/// See also [LanguageSetting].
@ProviderFor(LanguageSetting)
final languageSettingProvider =
    AutoDisposeNotifierProvider<LanguageSetting, String>.internal(
  LanguageSetting.new,
  name: r'languageSettingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$languageSettingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LanguageSetting = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
