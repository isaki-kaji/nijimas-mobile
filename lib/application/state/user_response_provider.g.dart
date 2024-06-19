// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileInfoHash() => r'8435ca63b7f3818f2ac6b7de64ae060f9e92f5f4';

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

/// See also [UserProfileInfo].
@ProviderFor(UserProfileInfo)
const userProfileInfoProvider = UserProfileInfoFamily();

/// See also [UserProfileInfo].
class UserProfileInfoFamily extends Family<AsyncValue<UserProfile?>> {
  /// See also [UserProfileInfo].
  const UserProfileInfoFamily();

  /// See also [UserProfileInfo].
  UserProfileInfoProvider call(
    String uid,
  ) {
    return UserProfileInfoProvider(
      uid,
    );
  }

  @override
  UserProfileInfoProvider getProviderOverride(
    covariant UserProfileInfoProvider provider,
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
  String? get name => r'userProfileInfoProvider';
}

/// See also [UserProfileInfo].
class UserProfileInfoProvider extends AutoDisposeFutureProvider<UserProfile?> {
  /// See also [UserProfileInfo].
  UserProfileInfoProvider(
    String uid,
  ) : this._internal(
          (ref) => UserProfileInfo(
            ref as UserProfileInfoRef,
            uid,
          ),
          from: userProfileInfoProvider,
          name: r'userProfileInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userProfileInfoHash,
          dependencies: UserProfileInfoFamily._dependencies,
          allTransitiveDependencies:
              UserProfileInfoFamily._allTransitiveDependencies,
          uid: uid,
        );

  UserProfileInfoProvider._internal(
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
    FutureOr<UserProfile?> Function(UserProfileInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProfileInfoProvider._internal(
        (ref) => create(ref as UserProfileInfoRef),
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
  AutoDisposeFutureProviderElement<UserProfile?> createElement() {
    return _UserProfileInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileInfoProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserProfileInfoRef on AutoDisposeFutureProviderRef<UserProfile?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserProfileInfoProviderElement
    extends AutoDisposeFutureProviderElement<UserProfile?>
    with UserProfileInfoRef {
  _UserProfileInfoProviderElement(super.provider);

  @override
  String get uid => (origin as UserProfileInfoProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
