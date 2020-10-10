import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PruuuBottomSheet extends StatelessWidget {
  BuildContext context;
  Widget child;

  PruuuBottomSheet({
    @required this.context,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            top: Radius.circular(20),
          ),
        ),
        builder: build);
  }
}
