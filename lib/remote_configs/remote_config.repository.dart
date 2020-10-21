import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepository {
  Future<RemoteConfig> fetchConfig() async {
    return await RemoteConfig.instance;
  }
}

enum RemoteConfigType {
  disclaimer,
}
