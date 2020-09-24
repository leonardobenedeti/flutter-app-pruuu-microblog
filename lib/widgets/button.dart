import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PruuuButton extends StatelessWidget {
  Widget child;
  Function onPressed;
  bool loading;
  ButtonType buttonType;

  PruuuButton(
      {@required this.child,
      @required this.onPressed,
      this.loading = false,
      this.buttonType = ButtonType.primary});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: loading ? _loading(context) : child,
      onPressed: onPressed,
      color: buttonType.getColor(context),
      textColor: buttonType.getTextColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _loading(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

enum ButtonType { primary, clear, danger }

extension ThemeForType on ButtonType {
  String get name => describeEnum(this);

  Color getTextColor(BuildContext context) {
    switch (this) {
      case ButtonType.clear:
        return Theme.of(context).accentColor;
        break;
      case ButtonType.danger:
        return Theme.of(context).errorColor;
        break;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  Color getColor(BuildContext context) {
    switch (this) {
      case ButtonType.clear:
        return Colors.transparent;
        break;
      case ButtonType.danger:
        return Theme.of(context).backgroundColor;
        break;
      default:
        return Theme.of(context).accentColor;
    }
  }
}
