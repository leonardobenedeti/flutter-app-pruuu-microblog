import 'dart:async';

import 'package:Pruuu/utils/strings.dart';
import 'package:Pruuu/view_model/feed/feed_view_model.dart';
import 'package:Pruuu/view_model/pruuu_it/pruuuit_view_model.dart';
import 'package:Pruuu/main_store.dart';
import 'package:Pruuu/model/pruuu_model.dart';
import 'package:Pruuu/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PruuuWidget extends StatefulWidget {
  final FirebaseUser user;

  PruuuWidget({this.user});

  @override
  _PruuuState createState() => _PruuuState();
}

class _PruuuState extends State<PruuuWidget> {
  String _currentPruuu = "";
  int _maxLengthPruuu = 280;
  int _maxLengthField = 300;

  FeedViewModel feedViewModel = MainStore().feedViewModel;
  PruuuItViewModel pruuuItViewModel = PruuuItViewModel();

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
                  Strings.cancel,
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
              cursorColor: Theme.of(context).accentColor,
              showCursor: true,
              maxLength: _maxLengthField,
              minLines: 8,
              maxLines: 8,
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: _handleChangeText,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: Strings.pruuuItPlaceholder,
              ),
              buildCounter: (context, {currentLength, isFocused, maxLength}) =>
                  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (currentLength > _maxLengthPruuu) ...[
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).accentColor),
                      child: Text(
                        "$currentLength ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    )
                  ] else ...[
                    Text(
                      "$currentLength ",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                  Text(
                    "/ $_maxLengthPruuu",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
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
      if (pruuuItViewModel.pruuuItState == PruuuItState.pruuublished) {
        Timer(Duration(milliseconds: 300), () {
          Navigator.pop(context);
          feedViewModel.needRefresh();
        });
      }
      return PruuuButton(
        child: pruuuItViewModel.pruuuItState == PruuuItState.pruuublished
            ? Icon(Icons.check)
            : Text(Strings.pruuuIt),
        loading: pruuuItViewModel.pruuuItState == PruuuItState.loading,
        onPressed: (_currentPruuu.length <= _maxLengthPruuu &&
                _currentPruuu.length > 0)
            ? () => _pruuuIt(context, _currentPruuu, widget.user)
            : null,
      );
    });
  }

  _pruuuIt(BuildContext context, String content, FirebaseUser user) {
    var pruuu = new Pruuu();
    pruuu.authorUID = user.uid;
    pruuu.timestamp = Timestamp.now();
    pruuu.content = content;
    pruuuItViewModel.pruuublish(pruuu);
  }
}
