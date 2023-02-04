import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

Future<void> initRemoteConfig() async {
  await _remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(
        seconds: 1), // a fetch will wait up to 10 seconds before timing out
    minimumFetchInterval: const Duration(
        seconds: 5), // fetch parameters will be cached for a maximum of 1 hour
  ));
  _fetchConfig();
}

FirebaseRemoteConfig? getRemoteConfig() {
  return _remoteConfig;
}

// Fetching, caching, and activating remote config
void _fetchConfig() async {
  await _remoteConfig.fetchAndActivate();
}

CollectionReference<Object?>? getCollectionData(
    {required String collectionName}) {
  final CollectionReference? collectionReference =
      FirebaseFirestore.instance.collection(collectionName);

  if (collectionReference != null) {
    return collectionReference;
  } else {
    return null;
  }
}

Map<String, dynamic>? getFirestoreSnapshotData(
    {required DocumentSnapshot<Object?> docSnapshot}) {
  Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
  return data;
}
