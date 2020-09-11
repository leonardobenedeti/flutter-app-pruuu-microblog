part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedLoading extends FeedState {}

class FeedError extends FeedState {
  String errorMessage;

  FeedError({this.errorMessage});
}

class FeedReady extends FeedState {
  List<Pruuu> feed;

  FeedReady({@required this.feed});
}

class FeedReloaded extends FeedState {
  List<Pruuu> newItensForFeed;
  FeedReloaded({@required this.newItensForFeed});
}

class PictureFounded extends FeedState {
  String picture;
  PictureFounded(this.picture);
}
