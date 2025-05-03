// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_map_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsMapNotifierHash() => r'4611096ecda849249abbe9b9501411e60403746b';

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
