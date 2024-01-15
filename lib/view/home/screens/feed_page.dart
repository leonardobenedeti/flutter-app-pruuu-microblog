import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/model/pruuu_model.dart';
import 'package:pruuu/utils/assets.dart';
import 'package:pruuu/utils/strings.dart';
import 'package:pruuu/view_model/auth/auth_view_model.dart';
import 'package:pruuu/view_model/feed/feed_view_model.dart';
import 'package:pruuu/view_model/pruuu_it/pruuuit_view_model.dart';
import 'package:pruuu/widgets/bottom_sheet.dart';
import 'package:pruuu/widgets/button.dart';
import 'package:pruuu/widgets/picture/picture_widget.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FeedViewModel feedViewModel = MainStore().feedViewModel;
  PruuuItViewModel pruuuItViewModel = PruuuItViewModel();
  AuthViewModel authViewModel = MainStore().authViewModel;

  List<Pruuu> feed = [];

  @override
  void initState() {
    feedViewModel.fetchFeed();
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
          switch (feedViewModel.feedState) {
            case FeedState.loading:
              return Center(child: CircularProgressIndicator());
            case FeedState.error:
              return _emptyState(withError: true);
            case FeedState.empty:
              return _emptyState();
            case FeedState.ready:
              return _build(context, false);
            case FeedState.reload:
              return _build(context, true);
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _build(BuildContext context, bool withReloadButton) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          if (feedViewModel.feed.length > 0) ...[
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: constraints.maxHeight,
                child: ListView.builder(
                    itemCount: feedViewModel.feed.length,
                    padding: EdgeInsets.only(bottom: 70),
                    itemBuilder: (context, position) {
                      return _pruuu(feedViewModel.feed[position]);
                    }),
              ),
            )
          ] else ...[
            _emptyState()
          ],
          if (withReloadButton) ...[
            Align(
                alignment: Alignment.topCenter,
                child: MaterialButton(
                  color: Theme.of(context).canvasColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 14,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        Strings.newPruuus,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  onPressed: feedViewModel.fetchFeed,
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
          if (pruuu.authorUID == authViewModel.user!.uid) ...[
            PruuuButton(
              fullButton: true,
              child: Text(Strings.removePruuu),
              buttonType: ButtonType.danger,
              onPressed: () {
                feedViewModel.removePruuuFromFeed(pruuu);
                Timer(
                    Duration(milliseconds: 500), () => Navigator.pop(context));
              },
            ),
          ] else ...[
            PruuuButton(
              fullButton: true,
              child: Text(Strings.rePruuuIt),
              buttonType: ButtonType.primary,
              onPressed: () => _repruuuit(pruuu),
            ),
          ],
          PruuuButton(
            fullButton: true,
            child: Text(Strings.cancel),
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
    newPruuu.authorUID = authViewModel.user!.uid;
    newPruuu.timestamp = Timestamp.now();

    pruuuItViewModel.pruuublish(newPruuu);

    Timer(Duration(milliseconds: 300), () {
      Navigator.pop(context);
      feedViewModel.needRefresh();
    });
  }

  Widget _pruuu(Pruuu pruuu) {
    DateTime now = DateTime.now().subtract(Duration(days: 1));
    DateTime datePruuu = pruuu.timestamp!.toDate();
    var format =
        datePruuu.isAfter(now) ? DateFormat('HH:mm') : DateFormat('dd/MM/yyyy');
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
                  child: PictureWidget(pruuu.authorUID!)),
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
                              pruuu.displayName!,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              pruuu.authorUsername!,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              timeStamp,
                              style: Theme.of(context).textTheme.headlineMedium,
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
                        pruuu.content!,
                        style: Theme.of(context).textTheme.bodyLarge,
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

  Widget _emptyState({bool withError = false}) {
    double sizeState = withError ? .6 : .8;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          withError ? Strings.somethingIsWrong : Strings.noPruuusYet,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width * sizeState,
          child: Image.asset(
            withError ? Assets.errorState : Assets.emptyState,
          ),
        ),
      ],
    );
  }
}
