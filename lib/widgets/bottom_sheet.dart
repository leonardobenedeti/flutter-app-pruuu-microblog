import 'package:flutter/material.dart';

class PruuuBottomSheet extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final bool fullscreenDialog;

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
