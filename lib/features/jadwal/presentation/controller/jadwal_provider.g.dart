// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jadwal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jadwalHash() => r'fda48d5c0dd4c8b27d3aa7351b8135f163fd29f6';

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

/// See also [jadwal].
@ProviderFor(jadwal)
const jadwalProvider = JadwalFamily();

/// See also [jadwal].
class JadwalFamily extends Family<AsyncValue<List<MataKuliahData>>> {
  /// See also [jadwal].
  const JadwalFamily();

  /// See also [jadwal].
  JadwalProvider call(
    int day,
  ) {
    return JadwalProvider(
      day,
    );
  }

  @override
  JadwalProvider getProviderOverride(
    covariant JadwalProvider provider,
  ) {
    return call(
      provider.day,
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
  String? get name => r'jadwalProvider';
}

/// See also [jadwal].
class JadwalProvider extends AutoDisposeStreamProvider<List<MataKuliahData>> {
  /// See also [jadwal].
  JadwalProvider(
    int day,
  ) : this._internal(
          (ref) => jadwal(
            ref as JadwalRef,
            day,
          ),
          from: jadwalProvider,
          name: r'jadwalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$jadwalHash,
          dependencies: JadwalFamily._dependencies,
          allTransitiveDependencies: JadwalFamily._allTransitiveDependencies,
          day: day,
        );

  JadwalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final int day;

  @override
  Override overrideWith(
    Stream<List<MataKuliahData>> Function(JadwalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JadwalProvider._internal(
        (ref) => create(ref as JadwalRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<MataKuliahData>> createElement() {
    return _JadwalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JadwalProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin JadwalRef on AutoDisposeStreamProviderRef<List<MataKuliahData>> {
  /// The parameter `day` of this provider.
  int get day;
}

class _JadwalProviderElement
    extends AutoDisposeStreamProviderElement<List<MataKuliahData>>
    with JadwalRef {
  _JadwalProviderElement(super.provider);

  @override
  int get day => (origin as JadwalProvider).day;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
