// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_product_id_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedProductIdNotifierHash() =>
    r'64621ba9b9e007f0e12f8e112fe95a03f0df8fdf';

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

abstract class _$SelectedProductIdNotifier
    extends BuildlessAutoDisposeAsyncNotifier<int> {
  late final int index;

  FutureOr<int> build(
    int index,
  );
}

/// See also [SelectedProductIdNotifier].
@ProviderFor(SelectedProductIdNotifier)
const selectedProductIdNotifierProvider = SelectedProductIdNotifierFamily();

/// See also [SelectedProductIdNotifier].
class SelectedProductIdNotifierFamily extends Family<AsyncValue<int>> {
  /// See also [SelectedProductIdNotifier].
  const SelectedProductIdNotifierFamily();

  /// See also [SelectedProductIdNotifier].
  SelectedProductIdNotifierProvider call(
    int index,
  ) {
    return SelectedProductIdNotifierProvider(
      index,
    );
  }

  @override
  SelectedProductIdNotifierProvider getProviderOverride(
    covariant SelectedProductIdNotifierProvider provider,
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
  String? get name => r'selectedProductIdNotifierProvider';
}

/// See also [SelectedProductIdNotifier].
class SelectedProductIdNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SelectedProductIdNotifier,
        int> {
  /// See also [SelectedProductIdNotifier].
  SelectedProductIdNotifierProvider(
    int index,
  ) : this._internal(
          () => SelectedProductIdNotifier()..index = index,
          from: selectedProductIdNotifierProvider,
          name: r'selectedProductIdNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedProductIdNotifierHash,
          dependencies: SelectedProductIdNotifierFamily._dependencies,
          allTransitiveDependencies:
              SelectedProductIdNotifierFamily._allTransitiveDependencies,
          index: index,
        );

  SelectedProductIdNotifierProvider._internal(
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
  FutureOr<int> runNotifierBuild(
    covariant SelectedProductIdNotifier notifier,
  ) {
    return notifier.build(
      index,
    );
  }

  @override
  Override overrideWith(SelectedProductIdNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedProductIdNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SelectedProductIdNotifier, int>
      createElement() {
    return _SelectedProductIdNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedProductIdNotifierProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedProductIdNotifierRef on AutoDisposeAsyncNotifierProviderRef<int> {
  /// The parameter `index` of this provider.
  int get index;
}

class _SelectedProductIdNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SelectedProductIdNotifier,
        int> with SelectedProductIdNotifierRef {
  _SelectedProductIdNotifierProviderElement(super.provider);

  @override
  int get index => (origin as SelectedProductIdNotifierProvider).index;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
