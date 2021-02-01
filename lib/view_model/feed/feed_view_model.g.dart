// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedViewModel on _FeedViewModel, Store {
  final _$feedAtom = Atom(name: '_FeedViewModel.feed');

  @override
  List<Pruuu> get feed {
    _$feedAtom.reportRead();
    return super.feed;
  }

  @override
  set feed(List<Pruuu> value) {
    _$feedAtom.reportWrite(value, super.feed, () {
      super.feed = value;
    });
  }

  final _$feedStateAtom = Atom(name: '_FeedViewModel.feedState');

  @override
  FeedState get feedState {
    _$feedStateAtom.reportRead();
    return super.feedState;
  }

  @override
  set feedState(FeedState value) {
    _$feedStateAtom.reportWrite(value, super.feedState, () {
      super.feedState = value;
    });
  }

  final _$fetchFeedAsyncAction = AsyncAction('_FeedViewModel.fetchFeed');

  @override
  Future<FeedState> fetchFeed() {
    return _$fetchFeedAsyncAction.run(() => super.fetchFeed());
  }

  final _$removePruuuFromFeedAsyncAction =
      AsyncAction('_FeedViewModel.removePruuuFromFeed');

  @override
  Future<FeedState> removePruuuFromFeed(Pruuu pruuu) {
    return _$removePruuuFromFeedAsyncAction
        .run(() => super.removePruuuFromFeed(pruuu));
  }

  final _$_FeedViewModelActionController =
      ActionController(name: '_FeedViewModel');

  @override
  void needRefresh() {
    final _$actionInfo = _$_FeedViewModelActionController.startAction(
        name: '_FeedViewModel.needRefresh');
    try {
      return super.needRefresh();
    } finally {
      _$_FeedViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
feed: ${feed},
feedState: ${feedState}
    ''';
  }
}
