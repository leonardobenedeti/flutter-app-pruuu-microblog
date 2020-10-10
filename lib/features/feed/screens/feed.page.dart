import 'dart:async';

import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:Pruuu/features/pruuu/stores/pruuuit.store.dart';
import 'package:Pruuu/features/user/picture_widget/widget/picture.widget.dart';
import 'package:Pruuu/main.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:Pruuu/widgets/bottomSheet.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FeedStore feedStore = MainStore().feedStore;
  PruuuItStore pruuuItStore = PruuuItStore();

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
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: constraints.maxHeight,
              child: ListView.builder(
                  itemCount: feedStore.feed.length,
                  padding: EdgeInsets.only(bottom: 70),
                  itemBuilder: (context, position) {
                    return _pruuu(feedStore.feed[position]);
                  }),
            ),
          ),
          if (withReloadButton) ...[
            Align(
                alignment: Alignment.topCenter,
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 14,
                        color: Theme.of(context).textTheme.bodyText2.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Novos pruuus",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  onPressed: feedStore.fetchFeed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ))
          ],
        ],
      );
    });
  }

  void showSettingsPruuu(Pruuu pruuu) {
    PruuuBottomSheet(
      child: _settingsPruuu(pruuu),
      context: context,
    ).show();
  }

  Widget _settingsPruuu(Pruuu pruuu) {
    return Container(
      child: new Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          if (pruuu.authorUID == authStore.user.uid) ...[
            PruuuButton(
              child: Text("Remove pruuu"),
              buttonType: ButtonType.danger,
              onPressed: () {
                feedStore.removePruuuFromFeed(pruuu);
                Timer(
                    Duration(milliseconds: 500), () => Navigator.pop(context));
              },
            ),
          ] else ...[
            PruuuButton(
              child: Text("Re-Pruuu It"),
              buttonType: ButtonType.primary,
              onPressed: () => _repruuuit(pruuu),
            ),
          ],
          PruuuButton(
            child: Text("cancel"),
            buttonType: ButtonType.clear,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _repruuuit(Pruuu pruuu) {
    var newPruuu = Pruuu();
    newPruuu.content = "RP: ${pruuu.authorUsername}\n${pruuu.content}";
    newPruuu.authorUID = authStore.user.uid;
    newPruuu.timestamp = Timestamp.now();

    pruuuItStore.pruuublish(newPruuu);

    Timer(Duration(milliseconds: 300), () {
      Navigator.pop(context);
      feedStore.needRefresh();
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
        return Container(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pruuu.displayName,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              pruuu.authorUsername,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              timeStamp,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Material(
                                child: InkWell(
                                  child: Center(
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  onTap: () => showSettingsPruuu(pruuu),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Bubble(
                      margin: BubbleEdges.only(top: 4),
                      alignment: Alignment.topLeft,
                      nip: BubbleNip.leftTop,
                      color: Theme.of(context).cardColor,
                      child: Text(
                        pruuu.content,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
