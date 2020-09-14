import 'dart:async';

import 'package:Pruuu/features/feed/bloc/feed_bloc.dart';
import 'package:Pruuu/features/pruuu/bloc/pruuuit_bloc.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PruuuWidget extends StatefulWidget {
  FirebaseUser user;

  PruuuWidget({this.user});

  @override
  _PruuuState createState() => _PruuuState();
}

class _PruuuState extends State<PruuuWidget> {
  String _currentPruuu = "";
  int _maxLengthPruuu = 280;
  int _maxLengthField = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              _blocWrap()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              autofocus: true,
              cursorColor: Colors.black,
              showCursor: true,
              maxLength: _maxLengthField,
              minLines: 8,
              maxLines: 8,
              onChanged: _handleChangeText,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's your pruuu for today?"),
              buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "$currentLength ",
                    style: TextStyle(
                        color: currentLength > _maxLengthPruuu
                            ? Colors.red
                            : Colors.black),
                  ),
                  Text("/ $_maxLengthPruuu")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _handleChangeText(String text) {
    setState(() {
      _currentPruuu = text;
    });
  }

  Widget _pruuuButton(BuildContext context, dynamic state) {
    Widget contentButton;
    if (state is PruuuitPublished) {
      contentButton = Icon(
        Icons.check,
        color: Colors.white,
      );
    } else if (state is PruuuitLoading) {
      contentButton = CircularProgressIndicator();
    } else {
      contentButton = Text("Pruuu It");
    }
    return FlatButton(
      child: contentButton,
      onPressed: (_currentPruuu.length) <= _maxLengthPruuu
          ? () => _pruuuIt(context, _currentPruuu, widget.user)
          : null,
      textColor: Colors.white,
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _blocWrap() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PruuuitBloc>(
          create: (contextPruuuBloc) => PruuuitBloc(),
        ),
        BlocProvider<FeedBloc>(
          create: (contextFeedBloc) => FeedBloc()..add(FetchFeed()),
        ),
      ],
      child: BlocBuilder<FeedBloc, FeedState>(
        builder: (contextFeed, state) {
          List<Pruuu> feed = state is FeedReady ? state.feed : [];
          return BlocListener<PruuuitBloc, PruuuitState>(
            listener: (context, state) {
              if (state is PruuuitPublished) {
                Timer(Duration(milliseconds: 300), () {
                  Navigator.pop(context);
                  BlocProvider.of<FeedBloc>(contextFeed)
                    ..add(UpdateFeed(feed: feed));
                });
              }
            },
            child: BlocBuilder<PruuuitBloc, PruuuitState>(
              builder: (context, state) => _pruuuButton(context, state),
            ),
          );
        },
      ),
    );
  }

  _pruuuIt(BuildContext context, String content, FirebaseUser user) {
    var pruuu = new Pruuu();
    pruuu.authorUID = user.uid;
    pruuu.authorUsername = user.displayName;
    pruuu.timestamp = Timestamp.now();
    pruuu.content = content;
    BlocProvider.of<PruuuitBloc>(context)..add(Pruuublish(pruuu: pruuu));
  }
}
