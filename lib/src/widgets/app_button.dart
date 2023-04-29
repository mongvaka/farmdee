import 'package:flutter/cupertino.dart';
import '../utils/constants.dart' as constants;

enum AppButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final String text;
  final AppButtonType? type;
  final Function()? onPressed;
  const AppButton({super.key, required this.text, this.onPressed, this.type});

  @override
  Widget build(BuildContext context) {
    // final color =
    var child = Text(
      text,
      style: TextStyle(
          color: onPressed == null ? constants.DISABLED_TEXT_COLOR : null),
    );
    const borderRadius = BorderRadius.all(Radius.circular(40));
    const primaryDisabledColor = constants.DISABLED_BG_COLOR;
    if (type == AppButtonType.primary) {
      return CupertinoButton.filled(
          disabledColor: primaryDisabledColor,
          onPressed: onPressed,
          borderRadius: borderRadius,
          child: child);
    }
    if (type == AppButtonType.secondary) {
      child = Text(
        text,
        style: TextStyle(
            color: onPressed == null
                ? constants.DISABLED_TEXT_COLOR
                : constants.TEXT_COLOR),
      );
      return Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: constants.BORDER_COLOR)),
        child: CupertinoButton(color: null, onPressed: onPressed, child: child),
      );
    }
    return CupertinoButton(
      disabledColor: primaryDisabledColor,
      onPressed: onPressed,
      borderRadius: borderRadius,
      child: child,
    );
  }
}
