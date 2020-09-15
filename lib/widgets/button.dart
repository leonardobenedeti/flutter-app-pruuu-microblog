import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PruuuButton extends StatelessWidget {
  Widget child;
  Function onPressed;
  bool loading;

  PruuuButton({
    @required this.child,
    @required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: loading ? _loading() : child,
      onPressed: onPressed,
      color: Colors.black,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _loading() {
    return SizedBox(
      height: 20,
      width: 20,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
