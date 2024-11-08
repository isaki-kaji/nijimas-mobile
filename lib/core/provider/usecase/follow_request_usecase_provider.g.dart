// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_request_usecase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$followRequestUsecaseHash() =>
    r'bb289657d7a275cccd788fafe4f09063aaadb5db';

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

/// See also [followRequestUsecase].
@ProviderFor(followRequestUsecase)
const followRequestUsecaseProvider = FollowRequestUsecaseFamily();

/// See also [followRequestUsecase].
class FollowRequestUsecaseFamily extends Family<FollowRequestUsecase> {
  /// See also [followRequestUsecase].
  const FollowRequestUsecaseFamily();

  /// See also [followRequestUsecase].
  FollowRequestUsecaseProvider call(
    String followingUid,
  ) {
    return FollowRequestUsecaseProvider(
      followingUid,
    );
  }

  @override
  FollowRequestUsecaseProvider getProviderOverride(
    covariant FollowRequestUsecaseProvider provider,
  ) {
    return call(
      provider.followingUid,
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
  String? get name => r'followRequestUsecaseProvider';
}

/// See also [followRequestUsecase].
class FollowRequestUsecaseProvider
    extends AutoDisposeProvider<FollowRequestUsecase> {
  /// See also [followRequestUsecase].
  FollowRequestUsecaseProvider(
    String followingUid,
  ) : this._internal(
          (ref) => followRequestUsecase(
            ref as FollowRequestUsecaseRef,
            followingUid,
          ),
          from: followRequestUsecaseProvider,
          name: r'followRequestUsecaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$followRequestUsecaseHash,
          dependencies: FollowRequestUsecaseFamily._dependencies,
          allTransitiveDependencies:
              FollowRequestUsecaseFamily._allTransitiveDependencies,
          followingUid: followingUid,
        );

  FollowRequestUsecaseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.followingUid,
  }) : super.internal();

  final String followingUid;

  @override
  Override overrideWith(
    FollowRequestUsecase Function(FollowRequestUsecaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FollowRequestUsecaseProvider._internal(
        (ref) => create(ref as FollowRequestUsecaseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        followingUid: followingUid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FollowRequestUsecase> createElement() {
    return _FollowRequestUsecaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FollowRequestUsecaseProvider &&
        other.followingUid == followingUid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, followingUid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FollowRequestUsecaseRef on AutoDisposeProviderRef<FollowRequestUsecase> {
  /// The parameter `followingUid` of this provider.
  String get followingUid;
}

class _FollowRequestUsecaseProviderElement
    extends AutoDisposeProviderElement<FollowRequestUsecase>
    with FollowRequestUsecaseRef {
  _FollowRequestUsecaseProviderElement(super.provider);

  @override
  String get followingUid =>
      (origin as FollowRequestUsecaseProvider).followingUid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
