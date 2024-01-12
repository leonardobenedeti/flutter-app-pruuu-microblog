import 'package:mobx/mobx.dart';
import 'package:pruuu/themes/theme_store.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';
import 'package:pruuu/view_model/feed/feed_view_model.dart';
import 'package:pruuu/view_model/picture/picture_view_model.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

final _feedViewModel = FeedViewModel();
final _authViewModel = AuthViewModel();
final _pictureViewModel = PictureViewModel();
final _themeStore = ThemeStore();

abstract class _MainStore with Store {
  @observable
  AuthViewModel authViewModel = _authViewModel;

  @observable
  FeedViewModel feedViewModel = _feedViewModel;

  @observable
  PictureViewModel pictureViewModel = _pictureViewModel;

  @observable
  ThemeStore themeStore = _themeStore;
}
