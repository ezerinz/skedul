// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tugas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tugasHash() => r'519e847d447ae838f0a307a278d1b2a06a38f085';

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

/// See also [tugas].
@ProviderFor(tugas)
const tugasProvider = TugasFamily();

/// See also [tugas].
class TugasFamily extends Family<AsyncValue<List<TugasModel>>> {
  /// See also [tugas].
  const TugasFamily();

  /// See also [tugas].
  TugasProvider call(
    DateTime date, {
    bool tugasDekat = false,
  }) {
    return TugasProvider(
      date,
      tugasDekat: tugasDekat,
    );
  }

  @override
  TugasProvider getProviderOverride(
    covariant TugasProvider provider,
  ) {
    return call(
      provider.date,
      tugasDekat: provider.tugasDekat,
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
  String? get name => r'tugasProvider';
}

/// See also [tugas].
class TugasProvider extends AutoDisposeStreamProvider<List<TugasModel>> {
  /// See also [tugas].
  TugasProvider(
    DateTime date, {
    bool tugasDekat = false,
  }) : this._internal(
          (ref) => tugas(
            ref as TugasRef,
            date,
            tugasDekat: tugasDekat,
          ),
          from: tugasProvider,
          name: r'tugasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tugasHash,
          dependencies: TugasFamily._dependencies,
          allTransitiveDependencies: TugasFamily._allTransitiveDependencies,
          date: date,
          tugasDekat: tugasDekat,
        );

  TugasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
    required this.tugasDekat,
  }) : super.internal();

  final DateTime date;
  final bool tugasDekat;

  @override
  Override overrideWith(
    Stream<List<TugasModel>> Function(TugasRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TugasProvider._internal(
        (ref) => create(ref as TugasRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
        tugasDekat: tugasDekat,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TugasModel>> createElement() {
    return _TugasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TugasProvider &&
        other.date == date &&
        other.tugasDekat == tugasDekat;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);
    hash = _SystemHash.combine(hash, tugasDekat.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TugasRef on AutoDisposeStreamProviderRef<List<TugasModel>> {
  /// The parameter `date` of this provider.
  DateTime get date;

  /// The parameter `tugasDekat` of this provider.
  bool get tugasDekat;
}

class _TugasProviderElement
    extends AutoDisposeStreamProviderElement<List<TugasModel>> with TugasRef {
  _TugasProviderElement(super.provider);

  @override
  DateTime get date => (origin as TugasProvider).date;
  @override
  bool get tugasDekat => (origin as TugasProvider).tugasDekat;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
