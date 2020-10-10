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
  FeedStateNew feedState = FeedStateNew.initial;

  @action
  Future<FeedStateNew> fetchFeed() async {
    feedState = FeedStateNew.loading;
    try {
      feed.clear();
      feed.addAll(await FeedRepository().fetchFeed());
      feedState = FeedStateNew.ready;
    } catch (e) {
      feedState = FeedStateNew.error;
    }
    return feedState;
  }

  @action
  void needRefresh() {
    feedState = FeedStateNew.reload;
  }

  PruuuItStore pruuuStore = PruuuItStore();

  @action
  Future<FeedStateNew> removePruuuFromFeed(Pruuu pruuu) async {
    feedState = FeedStateNew.loading;
    try {
      feed.remove(pruuu);
      pruuuStore.removePruuu(pruuu);
      feedState = FeedStateNew.ready;
    } catch (e) {
      feedState = FeedStateNew.error;
    }
    return feedState;
  }
}

enum FeedStateNew { initial, loading, ready, reload, error }
