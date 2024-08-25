// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthlySummaryPresentationHash() =>
    r'c3ae751e5e0197028d9e93a2054b31433676f011';

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

/// See also [monthlySummaryPresentation].
@ProviderFor(monthlySummaryPresentation)
const monthlySummaryPresentationProvider = MonthlySummaryPresentationFamily();

/// See also [monthlySummaryPresentation].
class MonthlySummaryPresentationFamily
    extends Family<AsyncValue<MonthlySummaryPresentation>> {
  /// See also [monthlySummaryPresentation].
  const MonthlySummaryPresentationFamily();

  /// See also [monthlySummaryPresentation].
  MonthlySummaryPresentationProvider call(
    String year,
    String month,
  ) {
    return MonthlySummaryPresentationProvider(
      year,
      month,
    );
  }

  @override
  MonthlySummaryPresentationProvider getProviderOverride(
    covariant MonthlySummaryPresentationProvider provider,
  ) {
    return call(
      provider.year,
      provider.month,
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
  String? get name => r'monthlySummaryPresentationProvider';
}

/// See also [monthlySummaryPresentation].
class MonthlySummaryPresentationProvider
    extends AutoDisposeFutureProvider<MonthlySummaryPresentation> {
  /// See also [monthlySummaryPresentation].
  MonthlySummaryPresentationProvider(
    String year,
    String month,
  ) : this._internal(
          (ref) => monthlySummaryPresentation(
            ref as MonthlySummaryPresentationRef,
            year,
            month,
          ),
          from: monthlySummaryPresentationProvider,
          name: r'monthlySummaryPresentationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlySummaryPresentationHash,
          dependencies: MonthlySummaryPresentationFamily._dependencies,
          allTransitiveDependencies:
              MonthlySummaryPresentationFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  MonthlySummaryPresentationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final String year;
  final String month;

  @override
  Override overrideWith(
    FutureOr<MonthlySummaryPresentation> Function(
            MonthlySummaryPresentationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlySummaryPresentationProvider._internal(
        (ref) => create(ref as MonthlySummaryPresentationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MonthlySummaryPresentation> createElement() {
    return _MonthlySummaryPresentationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlySummaryPresentationProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MonthlySummaryPresentationRef
    on AutoDisposeFutureProviderRef<MonthlySummaryPresentation> {
  /// The parameter `year` of this provider.
  String get year;

  /// The parameter `month` of this provider.
  String get month;
}

class _MonthlySummaryPresentationProviderElement
    extends AutoDisposeFutureProviderElement<MonthlySummaryPresentation>
    with MonthlySummaryPresentationRef {
  _MonthlySummaryPresentationProviderElement(super.provider);

  @override
  String get year => (origin as MonthlySummaryPresentationProvider).year;
  @override
  String get month => (origin as MonthlySummaryPresentationProvider).month;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
