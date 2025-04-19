// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_usecase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteUsecaseHash() => r'5729aff586a81c08581382f48fcfc2fa87412d24';

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

/// See also [favoriteUsecase].
@ProviderFor(favoriteUsecase)
const favoriteUsecaseProvider = FavoriteUsecaseFamily();

/// See also [favoriteUsecase].
class FavoriteUsecaseFamily extends Family<FavoriteUsecase> {
  /// See also [favoriteUsecase].
  const FavoriteUsecaseFamily();

  /// See also [favoriteUsecase].
  FavoriteUsecaseProvider call(
    PostQuery query,
  ) {
    return FavoriteUsecaseProvider(
      query,
    );
  }

  @override
  FavoriteUsecaseProvider getProviderOverride(
    covariant FavoriteUsecaseProvider provider,
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
  String? get name => r'favoriteUsecaseProvider';
}

/// See also [favoriteUsecase].
class FavoriteUsecaseProvider extends Provider<FavoriteUsecase> {
  /// See also [favoriteUsecase].
  FavoriteUsecaseProvider(
    PostQuery query,
  ) : this._internal(
          (ref) => favoriteUsecase(
            ref as FavoriteUsecaseRef,
            query,
          ),
          from: favoriteUsecaseProvider,
          name: r'favoriteUsecaseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$favoriteUsecaseHash,
          dependencies: FavoriteUsecaseFamily._dependencies,
          allTransitiveDependencies:
              FavoriteUsecaseFamily._allTransitiveDependencies,
          query: query,
        );

  FavoriteUsecaseProvider._internal(
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
  Override overrideWith(
    FavoriteUsecase Function(FavoriteUsecaseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FavoriteUsecaseProvider._internal(
        (ref) => create(ref as FavoriteUsecaseRef),
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
  ProviderElement<FavoriteUsecase> createElement() {
    return _FavoriteUsecaseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteUsecaseProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FavoriteUsecaseRef on ProviderRef<FavoriteUsecase> {
  /// The parameter `query` of this provider.
  PostQuery get query;
}

class _FavoriteUsecaseProviderElement extends ProviderElement<FavoriteUsecase>
    with FavoriteUsecaseRef {
  _FavoriteUsecaseProviderElement(super.provider);

  @override
  PostQuery get query => (origin as FavoriteUsecaseProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
