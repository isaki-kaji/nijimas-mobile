// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersInfoHash() => r'c280a09257b31fe3331b1556b060753557e18d0a';

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

/// See also [usersInfo].
@ProviderFor(usersInfo)
const usersInfoProvider = UsersInfoFamily();

/// See also [usersInfo].
class UsersInfoFamily extends Family<AsyncValue<List<UserInfo>>> {
  /// See also [usersInfo].
  const UsersInfoFamily();

  /// See also [usersInfo].
  UsersInfoProvider call(
    ({UserRelationType type, String uid}) args,
  ) {
    return UsersInfoProvider(
      args,
    );
  }

  @override
  UsersInfoProvider getProviderOverride(
    covariant UsersInfoProvider provider,
  ) {
    return call(
      provider.args,
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
  String? get name => r'usersInfoProvider';
}

/// See also [usersInfo].
class UsersInfoProvider extends AutoDisposeFutureProvider<List<UserInfo>> {
  /// See also [usersInfo].
  UsersInfoProvider(
    ({UserRelationType type, String uid}) args,
  ) : this._internal(
          (ref) => usersInfo(
            ref as UsersInfoRef,
            args,
          ),
          from: usersInfoProvider,
          name: r'usersInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$usersInfoHash,
          dependencies: UsersInfoFamily._dependencies,
          allTransitiveDependencies: UsersInfoFamily._allTransitiveDependencies,
          args: args,
        );

  UsersInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final ({UserRelationType type, String uid}) args;

  @override
  Override overrideWith(
    FutureOr<List<UserInfo>> Function(UsersInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsersInfoProvider._internal(
        (ref) => create(ref as UsersInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserInfo>> createElement() {
    return _UsersInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersInfoProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UsersInfoRef on AutoDisposeFutureProviderRef<List<UserInfo>> {
  /// The parameter `args` of this provider.
  ({UserRelationType type, String uid}) get args;
}

class _UsersInfoProviderElement
    extends AutoDisposeFutureProviderElement<List<UserInfo>> with UsersInfoRef {
  _UsersInfoProviderElement(super.provider);

  @override
  ({UserRelationType type, String uid}) get args =>
      (origin as UsersInfoProvider).args;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
