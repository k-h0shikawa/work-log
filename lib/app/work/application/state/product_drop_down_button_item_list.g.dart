// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_drop_down_button_item_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productDropDownButtonItemListNotifierHash() =>
    r'e6a50498d79901e46b5fda513b0215c6420322ac';

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

abstract class _$ProductDropDownButtonItemListNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Map<int, String>> {
  late final int index;

  FutureOr<Map<int, String>> build(
    int index,
  );
}

/// See also [ProductDropDownButtonItemListNotifier].
@ProviderFor(ProductDropDownButtonItemListNotifier)
const productDropDownButtonItemListNotifierProvider =
    ProductDropDownButtonItemListNotifierFamily();

/// See also [ProductDropDownButtonItemListNotifier].
class ProductDropDownButtonItemListNotifierFamily
    extends Family<AsyncValue<Map<int, String>>> {
  /// See also [ProductDropDownButtonItemListNotifier].
  const ProductDropDownButtonItemListNotifierFamily();

  /// See also [ProductDropDownButtonItemListNotifier].
  ProductDropDownButtonItemListNotifierProvider call(
    int index,
  ) {
    return ProductDropDownButtonItemListNotifierProvider(
      index,
    );
  }

  @override
  ProductDropDownButtonItemListNotifierProvider getProviderOverride(
    covariant ProductDropDownButtonItemListNotifierProvider provider,
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
  String? get name => r'productDropDownButtonItemListNotifierProvider';
}

/// See also [ProductDropDownButtonItemListNotifier].
class ProductDropDownButtonItemListNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductDropDownButtonItemListNotifier, Map<int, String>> {
  /// See also [ProductDropDownButtonItemListNotifier].
  ProductDropDownButtonItemListNotifierProvider(
    int index,
  ) : this._internal(
          () => ProductDropDownButtonItemListNotifier()..index = index,
          from: productDropDownButtonItemListNotifierProvider,
          name: r'productDropDownButtonItemListNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productDropDownButtonItemListNotifierHash,
          dependencies:
              ProductDropDownButtonItemListNotifierFamily._dependencies,
          allTransitiveDependencies: ProductDropDownButtonItemListNotifierFamily
              ._allTransitiveDependencies,
          index: index,
        );

  ProductDropDownButtonItemListNotifierProvider._internal(
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
  FutureOr<Map<int, String>> runNotifierBuild(
    covariant ProductDropDownButtonItemListNotifier notifier,
  ) {
    return notifier.build(
      index,
    );
  }

  @override
  Override overrideWith(
      ProductDropDownButtonItemListNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDropDownButtonItemListNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductDropDownButtonItemListNotifier,
      Map<int, String>> createElement() {
    return _ProductDropDownButtonItemListNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDropDownButtonItemListNotifierProvider &&
        other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductDropDownButtonItemListNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Map<int, String>> {
  /// The parameter `index` of this provider.
  int get index;
}

class _ProductDropDownButtonItemListNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductDropDownButtonItemListNotifier,
        Map<int, String>> with ProductDropDownButtonItemListNotifierRef {
  _ProductDropDownButtonItemListNotifierProviderElement(super.provider);

  @override
  int get index =>
      (origin as ProductDropDownButtonItemListNotifierProvider).index;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
