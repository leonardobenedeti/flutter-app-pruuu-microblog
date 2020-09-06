import 'package:flutter/material.dart';

class PruuuWidget extends StatefulWidget {
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              FlatButton(
                child: Text("Pruuu It"),
                onPressed: _currentPruuu.length < _maxLengthPruuu
                    ? () => Navigator.pop(context)
                    : null,
                textColor: Colors.white,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          TextField(
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
}
