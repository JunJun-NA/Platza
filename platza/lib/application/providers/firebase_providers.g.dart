// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firestore)
final firestoreProvider = FirestoreProvider._();

final class FirestoreProvider extends $FunctionalProvider<FirebaseFirestore,
    FirebaseFirestore, FirebaseFirestore> with $Provider<FirebaseFirestore> {
  FirestoreProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firestoreProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firestoreHash() => r'864285def6284159b44f9598dcde96347e0c1dce';

@ProviderFor(firebaseHealthCheckService)
final firebaseHealthCheckServiceProvider =
    FirebaseHealthCheckServiceProvider._();

final class FirebaseHealthCheckServiceProvider extends $FunctionalProvider<
    FirebaseHealthCheckService,
    FirebaseHealthCheckService,
    FirebaseHealthCheckService> with $Provider<FirebaseHealthCheckService> {
  FirebaseHealthCheckServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseHealthCheckServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseHealthCheckServiceHash();

  @$internal
  @override
  $ProviderElement<FirebaseHealthCheckService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseHealthCheckService create(Ref ref) {
    return firebaseHealthCheckService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseHealthCheckService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseHealthCheckService>(value),
    );
  }
}

String _$firebaseHealthCheckServiceHash() =>
    r'2ad80caccd006b14ec80cbda107c17796452f17b';
