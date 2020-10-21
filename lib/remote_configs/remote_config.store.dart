import 'package:Pruuu/remote_configs/remote_config.repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mobx/mobx.dart';

part 'remote_config.store.g.dart';

class RemoteConfigStore = _RemoteConfigStore with _$RemoteConfigStore;

abstract class _RemoteConfigStore with Store {
  @observable
  bool disclaimerOn = true;

  @action
  Future<RemoteConfig> switchDisclaimer() async {
    final remoteConfig = await RemoteConfigRepository().fetchConfig();
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    return remoteConfig;
  }
}
