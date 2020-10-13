import 'package:Pruuu/features/feed/repository/feed.repository.dart';
import 'package:Pruuu/features/pruuu/stores/pruuuit.store.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:mobx/mobx.dart';

part 'feed.store.g.dart';

class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore with Store {
  @observable
  List<Pruuu> feed = [];

  @observable
  FeedState feedState = FeedState.initial;

  @action
  Future<FeedState> fetchFeed() async {
    feedState = FeedState.loading;
    try {
      feed.clear();
      feed.addAll(await FeedRepository().fetchFeed());
      feedState = feed.length > 0 ? FeedState.ready : FeedState.empty;
    } catch (e) {
      feedState = FeedState.error;
    }
    return feedState;
  }

  @action
  void needRefresh() {
    feedState = FeedState.reload;
  }

  PruuuItStore pruuuStore = PruuuItStore();

  @action
  Future<FeedState> removePruuuFromFeed(Pruuu pruuu) async {
    feedState = FeedState.loading;
    try {
      feed.remove(pruuu);
      pruuuStore.removePruuu(pruuu);
      feedState = feed.length > 0 ? FeedState.ready : FeedState.empty;
    } catch (e) {
      feedState = FeedState.error;
    }
    return feedState;
  }
}

enum FeedState { initial, loading, ready, reload, error, empty }
