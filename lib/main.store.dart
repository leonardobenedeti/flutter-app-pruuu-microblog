import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:mobx/mobx.dart';

part 'main.store.g.dart';

class MainStore = _MainStore with _$MainStore;

final _feedStore = FeedStore();

abstract class _MainStore with Store {
  @observable
  FeedStore feedStore = _feedStore;
}
