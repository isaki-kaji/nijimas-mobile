// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_by_uid_response.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsByUidResponseHash() =>
    r'bddd64678c57a85b73fbc20066ae00ecc0fa7bb1';

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

/// See also [postsByUidResponse].
@ProviderFor(postsByUidResponse)
const postsByUidResponseProvider = PostsByUidResponseFamily();

/// See also [postsByUidResponse].
class PostsByUidResponseFamily extends Family<AsyncValue<List<PostResponse>>> {
  /// See also [postsByUidResponse].
  const PostsByUidResponseFamily();

  /// See also [postsByUidResponse].
  PostsByUidResponseProvider call(
    String uid,
  ) {
    return PostsByUidResponseProvider(
      uid,
    );
  }

  @override
  PostsByUidResponseProvider getProviderOverride(
    covariant PostsByUidResponseProvider provider,
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
  String? get name => r'postsByUidResponseProvider';
}

/// See also [postsByUidResponse].
class PostsByUidResponseProvider
    extends AutoDisposeFutureProvider<List<PostResponse>> {
  /// See also [postsByUidResponse].
  PostsByUidResponseProvider(
    String uid,
  ) : this._internal(
          (ref) => postsByUidResponse(
            ref as PostsByUidResponseRef,
            uid,
          ),
          from: postsByUidResponseProvider,
          name: r'postsByUidResponseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsByUidResponseHash,
          dependencies: PostsByUidResponseFamily._dependencies,
          allTransitiveDependencies:
              PostsByUidResponseFamily._allTransitiveDependencies,
          uid: uid,
        );

  PostsByUidResponseProvider._internal(
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
    FutureOr<List<PostResponse>> Function(PostsByUidResponseRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostsByUidResponseProvider._internal(
        (ref) => create(ref as PostsByUidResponseRef),
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
  AutoDisposeFutureProviderElement<List<PostResponse>> createElement() {
    return _PostsByUidResponseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsByUidResponseProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsByUidResponseRef
    on AutoDisposeFutureProviderRef<List<PostResponse>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _PostsByUidResponseProviderElement
    extends AutoDisposeFutureProviderElement<List<PostResponse>>
    with PostsByUidResponseRef {
  _PostsByUidResponseProviderElement(super.provider);

  @override
  String get uid => (origin as PostsByUidResponseProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
