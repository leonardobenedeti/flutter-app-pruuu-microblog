// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedStore on _FeedStore, Store {
  final _$feedAtom = Atom(name: '_FeedStore.feed');

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

  final _$feedStateAtom = Atom(name: '_FeedStore.feedState');

  @override
  FeedStateNew get feedState {
    _$feedStateAtom.reportRead();
    return super.feedState;
  }

  @override
  set feedState(FeedStateNew value) {
    _$feedStateAtom.reportWrite(value, super.feedState, () {
      super.feedState = value;
    });
  }

  final _$fetchFeedAsyncAction = AsyncAction('_FeedStore.fetchFeed');

  @override
  Future<FeedStateNew> fetchFeed() {
    return _$fetchFeedAsyncAction.run(() => super.fetchFeed());
  }

  final _$_FeedStoreActionController = ActionController(name: '_FeedStore');

  @override
  void needRefresh() {
    final _$actionInfo = _$_FeedStoreActionController.startAction(
        name: '_FeedStore.needRefresh');
    try {
      return super.needRefresh();
    } finally {
      _$_FeedStoreActionController.endAction(_$actionInfo);
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
