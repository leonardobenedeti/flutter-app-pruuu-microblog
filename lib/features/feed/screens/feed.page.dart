import 'package:Pruuu/features/feed/bloc/feed_bloc.dart';
import 'package:Pruuu/features/feed/screens/picture.widget.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Pruuu> feed = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (context) => FeedBloc()..add(FetchFeed()),
      child: _listener(context),
    );
  }

  Widget _listener(BuildContext contextBloc) {
    return BlocListener<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FeedReady) {
          feed.clear();
          feed.addAll(state.feed);
        }
        if (state is FeedReloaded) {
          feed.clear();
          feed.addAll(state.newItensForFeed);
        }
      },
      child: BlocBuilder<FeedBloc, FeedState>(builder: (contextBloc, state) {
        if (state is FeedReady) {
          feed.clear();
          feed.addAll(state.feed);
          return _build(context, false);
        }
        if (state is FeedReloaded) {
          feed.clear();
          feed.addAll(state.newItensForFeed);
          return _build(context, true);
        }
        return CircularProgressIndicator();
      }),
    );
  }

  Widget _build(BuildContext context, bool withReloadButton) {
    return Stack(children: [
      if (withReloadButton) ...[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Colors.black,
                  offset: Offset.fromDirection(1),
                  spreadRadius: 10)
            ],
          ),
          child: Text(
            "Novos Pruuus",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: feed.length,
          padding: EdgeInsets.only(bottom: 70),
          itemBuilder: (context, position) {
            return _pruuu(feed[position]);
          },
        ),
      ),
    ]);
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
