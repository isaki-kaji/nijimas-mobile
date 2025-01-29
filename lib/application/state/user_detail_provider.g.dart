// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDetailNotifierHash() =>
    r'67b15d6bcab17c4dd02ef97cd63061416d853b98';

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

abstract class _$UserDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<UserDetail> {
  late final String uid;

  FutureOr<UserDetail> build(
    String uid,
  );
}

/// See also [UserDetailNotifier].
@ProviderFor(UserDetailNotifier)
const userDetailNotifierProvider = UserDetailNotifierFamily();

/// See also [UserDetailNotifier].
class UserDetailNotifierFamily extends Family<AsyncValue<UserDetail>> {
  /// See also [UserDetailNotifier].
  const UserDetailNotifierFamily();

  /// See also [UserDetailNotifier].
  UserDetailNotifierProvider call(
    String uid,
  ) {
    return UserDetailNotifierProvider(
      uid,
    );
  }

  @override
  UserDetailNotifierProvider getProviderOverride(
    covariant UserDetailNotifierProvider provider,
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
  String? get name => r'userDetailNotifierProvider';
}

/// See also [UserDetailNotifier].
class UserDetailNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserDetailNotifier, UserDetail> {
  /// See also [UserDetailNotifier].
  UserDetailNotifierProvider(
    String uid,
  ) : this._internal(
          () => UserDetailNotifier()..uid = uid,
          from: userDetailNotifierProvider,
          name: r'userDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userDetailNotifierHash,
          dependencies: UserDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserDetailNotifierFamily._allTransitiveDependencies,
          uid: uid,
        );

  UserDetailNotifierProvider._internal(
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
  FutureOr<UserDetail> runNotifierBuild(
    covariant UserDetailNotifier notifier,
  ) {
    return notifier.build(
      uid,
    );
  }

  @override
  Override overrideWith(UserDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserDetailNotifierProvider._internal(
        () => create()..uid = uid,
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
  AutoDisposeAsyncNotifierProviderElement<UserDetailNotifier, UserDetail>
      createElement() {
    return _UserDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDetailNotifierProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserDetailNotifierRef on AutoDisposeAsyncNotifierProviderRef<UserDetail> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserDetailNotifier,
        UserDetail> with UserDetailNotifierRef {
  _UserDetailNotifierProviderElement(super.provider);

  @override
  String get uid => (origin as UserDetailNotifierProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
