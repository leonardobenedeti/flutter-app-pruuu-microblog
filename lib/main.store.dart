import 'package:Pruuu/features/auth/stores/auth.store.dart';
import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:Pruuu/features/user/picture_widget/stores/picture.store.dart';
import 'package:mobx/mobx.dart';

part 'main.store.g.dart';

class MainStore = _MainStore with _$MainStore;

final _feedStore = FeedStore();
final _authStore = AuthStore();
final _pictureStore = PictureStore();

abstract class _MainStore with Store {
  @observable
  AuthStore authStore = _authStore;

  @observable
  FeedStore feedStore = _feedStore;

  @observable
  PictureStore pictureStore = _pictureStore;
}
