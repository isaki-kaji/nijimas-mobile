// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_map_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsMapNotifierHash() => r'18b74cb5fed9399436e4a47f29eb5c52d499fd04';

/// See also [PostsMapNotifier].
@ProviderFor(PostsMapNotifier)
final postsMapNotifierProvider = AutoDisposeNotifierProvider<PostsMapNotifier,
    Map<PostQuery, PagingState<String, Post>>>.internal(
  PostsMapNotifier.new,
  name: r'postsMapNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postsMapNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostsMapNotifier
    = AutoDisposeNotifier<Map<PostQuery, PagingState<String, Post>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
