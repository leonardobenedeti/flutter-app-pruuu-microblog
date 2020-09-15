import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:Pruuu/features/user/picture_widget/widget/picture.widget.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FeedStore feedStore = MainStore().feedStore;

  List<Pruuu> feed = [];

  @override
  void initState() {
    feedStore.fetchFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _screenState());
  }

  Widget _screenState() {
    return Container(
      child: Observer(
        builder: (_) {
          switch (feedStore.feedState) {
            case FeedStateNew.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case FeedStateNew.error:
              return Text("ERROR");
              break;
            case FeedStateNew.ready:
              return _build(context, false);
              break;
            case FeedStateNew.reload:
              return _build(context, true);
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Widget _build(BuildContext context, bool withReloadButton) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
              child: Container(
            height: constraints.maxHeight,
            child: ListView.builder(
                itemCount: feedStore.feed.length,
                padding: EdgeInsets.only(bottom: 70),
                itemBuilder: (context, position) {
                  return _pruuu(feedStore.feed[position]);
                }),
          )),
          if (withReloadButton) ...[
            Align(
                alignment: Alignment.topCenter,
                child: MaterialButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Novos pruuus"),
                    ],
                  ),
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: feedStore.fetchFeed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ))
          ],
        ],
      );
    });
  }

  Widget _pruuu(Pruuu pruuu) {
    DateTime now = DateTime.now().subtract(Duration(days: 1));
    DateTime datePruuu = pruuu.timestamp.toDate();
    var format =
        datePruuu.isAfter(now) ? DateFormat('HH:mm') : DateFormat('dd/MM/yy');
    String timeStamp = format.format(datePruuu);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onLongPress: () => print("${pruuu.documentId()}"),
          child: Container(
            width: constraints.maxWidth,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(right: 10),
                    child: PictureWidget(pruuu.authorUID)),
                Container(
                  width: constraints.maxWidth * .8,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pruuu.authorUsername,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            timeStamp,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Bubble(
                        margin: BubbleEdges.only(top: 10),
                        alignment: Alignment.topLeft,
                        nip: BubbleNip.leftTop,
                        child: Text(pruuu.content),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
