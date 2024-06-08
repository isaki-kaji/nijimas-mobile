// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_by_uid_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsByUidNotifierHash() =>
    r'c5798d3f8fdc85010a0f664515487138dbf550ff';

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

abstract class _$PostsByUidNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PostResponse>> {
  late final String uid;

  FutureOr<List<PostResponse>> build(
    String uid,
  );
}

/// See also [PostsByUidNotifier].
@ProviderFor(PostsByUidNotifier)
const postsByUidNotifierProvider = PostsByUidNotifierFamily();

/// See also [PostsByUidNotifier].
class PostsByUidNotifierFamily extends Family<AsyncValue<List<PostResponse>>> {
  /// See also [PostsByUidNotifier].
  const PostsByUidNotifierFamily();

  /// See also [PostsByUidNotifier].
  PostsByUidNotifierProvider call(
    String uid,
  ) {
    return PostsByUidNotifierProvider(
      uid,
    );
  }

  @override
  PostsByUidNotifierProvider getProviderOverride(
    covariant PostsByUidNotifierProvider provider,
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
  String? get name => r'postsByUidNotifierProvider';
}

/// See also [PostsByUidNotifier].
class PostsByUidNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PostsByUidNotifier, List<PostResponse>> {
  /// See also [PostsByUidNotifier].
  PostsByUidNotifierProvider(
    String uid,
  ) : this._internal(
          () => PostsByUidNotifier()..uid = uid,
          from: postsByUidNotifierProvider,
          name: r'postsByUidNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsByUidNotifierHash,
          dependencies: PostsByUidNotifierFamily._dependencies,
          allTransitiveDependencies:
              PostsByUidNotifierFamily._allTransitiveDependencies,
          uid: uid,
        );

  PostsByUidNotifierProvider._internal(
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
  FutureOr<List<PostResponse>> runNotifierBuild(
    covariant PostsByUidNotifier notifier,
  ) {
    return notifier.build(
      uid,
    );
  }

  @override
  Override overrideWith(PostsByUidNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostsByUidNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PostsByUidNotifier,
      List<PostResponse>> createElement() {
    return _PostsByUidNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsByUidNotifierProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsByUidNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<PostResponse>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _PostsByUidNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostsByUidNotifier,
        List<PostResponse>> with PostsByUidNotifierRef {
  _PostsByUidNotifierProviderElement(super.provider);

  @override
  String get uid => (origin as PostsByUidNotifierProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
