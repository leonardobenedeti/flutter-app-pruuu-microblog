import 'dart:async';

import 'package:Pruuu/features/feed/stores/feed.store.dart';
import 'package:Pruuu/features/pruuu/stores/pruuuit.store.dart';
import 'package:Pruuu/main.store.dart';
import 'package:Pruuu/models/pruuu.model.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
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

  FeedStore feedStore = MainStore().feedStore;
  PruuuItStore pruuuItStore = PruuuItStore();

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
              _pruuuButton(context)
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

  Widget _pruuuButton(BuildContext context) {
    return Observer(builder: (_) {
      if (pruuuItStore.pruuuItState == PruuuItState.pruuublished) {
        Timer(Duration(milliseconds: 300), () {
          Navigator.pop(context);
          feedStore.needRefresh();
        });
      }
      return PruuuButton(
        child: pruuuItStore.pruuuItState == PruuuItState.pruuublished
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : Text("Pruuu It"),
        loading: pruuuItStore.pruuuItState == PruuuItState.loading,
        onPressed: (_currentPruuu.length) <= _maxLengthPruuu
            ? () => _pruuuIt(context, _currentPruuu, widget.user)
            : null,
      );
    });
  }

  _pruuuIt(BuildContext context, String content, FirebaseUser user) {
    var pruuu = new Pruuu();
    pruuu.authorUID = user.uid;
    pruuu.authorUsername = user.displayName;
    pruuu.timestamp = Timestamp.now();
    pruuu.content = content;
    pruuuItStore.pruuublish(pruuu);
  }
}
