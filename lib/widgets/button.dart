import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PruuuButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool loading;
  final ButtonType buttonType;
  final bool fullButton;

  PruuuButton({
    required this.child,
    this.onPressed,
    this.loading = false,
    this.buttonType = ButtonType.primary,
    this.fullButton = false,
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.icon:
        return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            child: InkWell(
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Center(child: child),
              ),
            ),
          ),
        );
      default:
        return ElevatedButton(
          child: _fullWrap(context, loading ? _loading(context) : child),
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).highlightColor,
            foregroundColor: Theme.of(context).hintColor,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Theme.of(context).hintColor,
          ),
        );
    }
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

  Widget _fullWrap(BuildContext context, Widget child) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: fullButton ? MediaQuery.of(context).size.width * .8 : null,
            child: Center(child: child),
          ),
        ]);
  }
}

enum ButtonType { primary, clear, danger, icon }

extension ThemeForType on ButtonType {
  String get name => describeEnum(this);

  Color getTextColor(BuildContext context) {
    switch (this) {
      case ButtonType.clear:
        return Theme.of(context).colorScheme.secondary;
      case ButtonType.danger:
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  Color getColor(BuildContext context) {
    switch (this) {
      case ButtonType.clear:
        return Colors.transparent;
      case ButtonType.danger:
        return Theme.of(context).colorScheme.background;
      default:
        return Theme.of(context).colorScheme.secondary;
    }
  }
}
