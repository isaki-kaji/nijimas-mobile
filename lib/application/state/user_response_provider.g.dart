// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userResponseHash() => r'ba9a6c5309fa33864c8077f046b63dbf74d5922f';

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

/// See also [userResponse].
@ProviderFor(userResponse)
const userResponseProvider = UserResponseFamily();

/// See also [userResponse].
class UserResponseFamily extends Family<AsyncValue<UserResponse?>> {
  /// See also [userResponse].
  const UserResponseFamily();

  /// See also [userResponse].
  UserResponseProvider call(
    String uid,
  ) {
    return UserResponseProvider(
      uid,
    );
  }

  @override
  UserResponseProvider getProviderOverride(
    covariant UserResponseProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'userResponseProvider';
}

/// See also [userResponse].
class UserResponseProvider extends AutoDisposeFutureProvider<UserResponse?> {
  /// See also [userResponse].
  UserResponseProvider(
    String uid,
  ) : this._internal(
          (ref) => userResponse(
            ref as UserResponseRef,
            uid,
          ),
          from: userResponseProvider,
          name: r'userResponseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userResponseHash,
          dependencies: UserResponseFamily._dependencies,
          allTransitiveDependencies:
              UserResponseFamily._allTransitiveDependencies,
          uid: uid,
        );

  UserResponseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<UserResponse?> Function(UserResponseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserResponseProvider._internal(
        (ref) => create(ref as UserResponseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserResponse?> createElement() {
    return _UserResponseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserResponseProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserResponseRef on AutoDisposeFutureProviderRef<UserResponse?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserResponseProviderElement
    extends AutoDisposeFutureProviderElement<UserResponse?>
    with UserResponseRef {
  _UserResponseProviderElement(super.provider);

  @override
  String get uid => (origin as UserResponseProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
