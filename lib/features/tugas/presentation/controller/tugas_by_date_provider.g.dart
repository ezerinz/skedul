// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tugas_by_date_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tugasByDateHash() => r'3b63f73de5d97cab076fb5ee00d740b4ae1e8356';

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

/// See also [tugasByDate].
@ProviderFor(tugasByDate)
const tugasByDateProvider = TugasByDateFamily();

/// See also [tugasByDate].
class TugasByDateFamily
    extends Family<AsyncValue<LinkedHashMap<DateTime, List<TugasModel>>>> {
  /// See also [tugasByDate].
  const TugasByDateFamily();

  /// See also [tugasByDate].
  TugasByDateProvider call(
    DateTime start,
    DateTime end,
  ) {
    return TugasByDateProvider(
      start,
      end,
    );
  }

  @override
  TugasByDateProvider getProviderOverride(
    covariant TugasByDateProvider provider,
  ) {
    return call(
      provider.start,
      provider.end,
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
  String? get name => r'tugasByDateProvider';
}

/// See also [tugasByDate].
class TugasByDateProvider extends AutoDisposeStreamProvider<
    LinkedHashMap<DateTime, List<TugasModel>>> {
  /// See also [tugasByDate].
  TugasByDateProvider(
    DateTime start,
    DateTime end,
  ) : this._internal(
          (ref) => tugasByDate(
            ref as TugasByDateRef,
            start,
            end,
          ),
          from: tugasByDateProvider,
          name: r'tugasByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tugasByDateHash,
          dependencies: TugasByDateFamily._dependencies,
          allTransitiveDependencies:
              TugasByDateFamily._allTransitiveDependencies,
          start: start,
          end: end,
        );

  TugasByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.start,
    required this.end,
  }) : super.internal();

  final DateTime start;
  final DateTime end;

  @override
  Override overrideWith(
    Stream<LinkedHashMap<DateTime, List<TugasModel>>> Function(
            TugasByDateRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TugasByDateProvider._internal(
        (ref) => create(ref as TugasByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        start: start,
        end: end,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<LinkedHashMap<DateTime, List<TugasModel>>>
      createElement() {
    return _TugasByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TugasByDateProvider &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, start.hashCode);
    hash = _SystemHash.combine(hash, end.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TugasByDateRef
    on AutoDisposeStreamProviderRef<LinkedHashMap<DateTime, List<TugasModel>>> {
  /// The parameter `start` of this provider.
  DateTime get start;

  /// The parameter `end` of this provider.
  DateTime get end;
}

class _TugasByDateProviderElement extends AutoDisposeStreamProviderElement<
    LinkedHashMap<DateTime, List<TugasModel>>> with TugasByDateRef {
  _TugasByDateProviderElement(super.provider);

  @override
  DateTime get start => (origin as TugasByDateProvider).start;
  @override
  DateTime get end => (origin as TugasByDateProvider).end;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
