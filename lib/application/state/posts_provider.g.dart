// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsNotifierHash() => r'740eff60112fad74abe94f910c0ed1ad024e4dae';

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

abstract class _$PostsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Post>> {
  late final PostQuery query;

  FutureOr<List<Post>> build(
    PostQuery query,
  );
}

/// See also [PostsNotifier].
@ProviderFor(PostsNotifier)
const postsNotifierProvider = PostsNotifierFamily();

/// See also [PostsNotifier].
class PostsNotifierFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [PostsNotifier].
  const PostsNotifierFamily();

  /// See also [PostsNotifier].
  PostsNotifierProvider call(
    PostQuery query,
  ) {
    return PostsNotifierProvider(
      query,
    );
  }

  @override
  PostsNotifierProvider getProviderOverride(
    covariant PostsNotifierProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'postsNotifierProvider';
}

/// See also [PostsNotifier].
class PostsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostsNotifier, List<Post>> {
  /// See also [PostsNotifier].
  PostsNotifierProvider(
    PostQuery query,
  ) : this._internal(
          () => PostsNotifier()..query = query,
          from: postsNotifierProvider,
          name: r'postsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsNotifierHash,
          dependencies: PostsNotifierFamily._dependencies,
          allTransitiveDependencies:
              PostsNotifierFamily._allTransitiveDependencies,
          query: query,
        );

  PostsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final PostQuery query;

  @override
  FutureOr<List<Post>> runNotifierBuild(
    covariant PostsNotifier notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(PostsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostsNotifierProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostsNotifier, List<Post>>
      createElement() {
    return _PostsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostsNotifierProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostsNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<Post>> {
  /// The parameter `query` of this provider.
  PostQuery get query;
}

class _PostsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostsNotifier, List<Post>>
    with PostsNotifierRef {
  _PostsNotifierProviderElement(super.provider);

  @override
  PostQuery get query => (origin as PostsNotifierProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
