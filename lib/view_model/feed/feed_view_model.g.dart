// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedViewModel on _FeedViewModel, Store {
  late final _$feedAtom = Atom(name: '_FeedViewModel.feed', context: context);

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

  late final _$feedStateAtom =
      Atom(name: '_FeedViewModel.feedState', context: context);

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

  late final _$fetchFeedAsyncAction =
      AsyncAction('_FeedViewModel.fetchFeed', context: context);

  @override
  Future<FeedState> fetchFeed() {
    return _$fetchFeedAsyncAction.run(() => super.fetchFeed());
  }

  late final _$removePruuuFromFeedAsyncAction =
      AsyncAction('_FeedViewModel.removePruuuFromFeed', context: context);

  @override
  Future<FeedState> removePruuuFromFeed(Pruuu pruuu) {
    return _$removePruuuFromFeedAsyncAction
        .run(() => super.removePruuuFromFeed(pruuu));
  }

  late final _$_FeedViewModelActionController =
      ActionController(name: '_FeedViewModel', context: context);

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
