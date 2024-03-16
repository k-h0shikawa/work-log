// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_product_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedProductNotifierHash() =>
    r'84b58cf67aa3d4ef16c259eceffd97fee7364c08';

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

abstract class _$SelectedProductNotifier
    extends BuildlessAutoDisposeAsyncNotifier<InProgressProduct> {
  late final int index;

  FutureOr<InProgressProduct> build(
    int index,
  );
}

/// See also [SelectedProductNotifier].
@ProviderFor(SelectedProductNotifier)
const selectedProductNotifierProvider = SelectedProductNotifierFamily();

/// See also [SelectedProductNotifier].
class SelectedProductNotifierFamily
    extends Family<AsyncValue<InProgressProduct>> {
  /// See also [SelectedProductNotifier].
  const SelectedProductNotifierFamily();

  /// See also [SelectedProductNotifier].
  SelectedProductNotifierProvider call(
    int index,
  ) {
    return SelectedProductNotifierProvider(
      index,
    );
  }

  @override
  SelectedProductNotifierProvider getProviderOverride(
    covariant SelectedProductNotifierProvider provider,
  ) {
    return call(
      provider.index,
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
  String? get name => r'selectedProductNotifierProvider';
}

/// See also [SelectedProductNotifier].
class SelectedProductNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SelectedProductNotifier,
        InProgressProduct> {
  /// See also [SelectedProductNotifier].
  SelectedProductNotifierProvider(
    int index,
  ) : this._internal(
          () => SelectedProductNotifier()..index = index,
          from: selectedProductNotifierProvider,
          name: r'selectedProductNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedProductNotifierHash,
          dependencies: SelectedProductNotifierFamily._dependencies,
          allTransitiveDependencies:
              SelectedProductNotifierFamily._allTransitiveDependencies,
          index: index,
        );

  SelectedProductNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
  }) : super.internal();

  final int index;

  @override
  FutureOr<InProgressProduct> runNotifierBuild(
    covariant SelectedProductNotifier notifier,
  ) {
    return notifier.build(
      index,
    );
  }

  @override
  Override overrideWith(SelectedProductNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedProductNotifierProvider._internal(
        () => create()..index = index,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SelectedProductNotifier,
      InProgressProduct> createElement() {
    return _SelectedProductNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedProductNotifierProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedProductNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<InProgressProduct> {
  /// The parameter `index` of this provider.
  int get index;
}

class _SelectedProductNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SelectedProductNotifier,
        InProgressProduct> with SelectedProductNotifierRef {
  _SelectedProductNotifierProviderElement(super.provider);

  @override
  int get index => (origin as SelectedProductNotifierProvider).index;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
