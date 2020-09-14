import 'dart:async';

import 'package:Pruuu/features/feed/repository/feed.repository.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedLoading());

  final feedRepository = FeedRepository();

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is FetchFeed) {
      yield FeedLoading();
      List<Pruuu> feed = await feedRepository.fetchFeed();
      yield FeedReady(feed: feed);
    }

    if (event is UpdateFeed) {
      yield FeedReloaded(newItensForFeed: event.feed);
    }

    if (event is FetchPicture) {
      yield FeedLoading();
      String picture = await feedRepository.fetchPicture(event.authorUID);
      yield PictureFounded(picture);
    }
  }
}
