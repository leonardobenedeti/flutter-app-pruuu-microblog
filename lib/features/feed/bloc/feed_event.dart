part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FetchFeed extends FeedEvent {}

class FetchPicture extends FeedEvent {
  String authorUID;

  FetchPicture({@required this.authorUID});
}
