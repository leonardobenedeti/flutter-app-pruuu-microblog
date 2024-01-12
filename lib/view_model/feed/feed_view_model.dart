import 'package:pruuu/repository/feed_repository.dart';
import 'package:pruuu/view_model/pruuu_it/pruuuit_view_model.dart';
import 'package:pruuu/model/pruuu_model.dart';
import 'package:mobx/mobx.dart';

part 'feed_view_model.g.dart';

class FeedViewModel = _FeedViewModel with _$FeedViewModel;

abstract class _FeedViewModel with Store {
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

  PruuuItViewModel pruuuStore = PruuuItViewModel();

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
