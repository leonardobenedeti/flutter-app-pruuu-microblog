import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'main.store.g.dart';

// This is the class used by rest of your codebase
class MainStore = _MainStore with _$MainStore;

final _feedStore = FeedStore();

// The store-class
abstract class _MainStore with Store {
  // @observable
  // Counter counter = _counter;

  @observable
  FeedStore feedStore = _feedStore;
}
