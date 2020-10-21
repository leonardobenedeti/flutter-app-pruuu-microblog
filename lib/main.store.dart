import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:Pruuu/features/picture/stores/picture.store.dart';
import 'package:Pruuu/remote_configs/remote_config.store.dart';
import 'package:Pruuu/themes/theme.store.dart';
import 'package:mobx/mobx.dart';

part 'main.store.g.dart';

class MainStore = _MainStore with _$MainStore;

final _feedStore = FeedStore();
final _authStore = AuthStore();
final _pictureStore = PictureStore();
final _themeStore = ThemeStore();
final _remoteConfigStore = RemoteConfigStore();

abstract class _MainStore with Store {
  @observable
  AuthStore authStore = _authStore;

  @observable
  FeedStore feedStore = _feedStore;

  @observable
  PictureStore pictureStore = _pictureStore;

  @observable
  ThemeStore themeStore = _themeStore;

  @observable
  RemoteConfigStore remoteConfigStore = _remoteConfigStore;
}
