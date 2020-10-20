import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PruuuBottomSheet extends StatelessWidget {
  BuildContext context;
  Widget child;
  bool fullscreenDialog;

  PruuuBottomSheet(
      {@required this.context,
      @required this.child,
      this.fullscreenDialog = false});

  @override
  Widget build(BuildContext context) {
    return fullscreenDialog
        ? child
        : SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ));
  }

  void show() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(fullscreenDialog ? 0 : 20),
          ),
        ),
        builder: build);
  }
}
