import 'package:flutter/material.dart';

class CustomOutlinedButton {
  String _label = "Label";
  double _sizedBoxHeight = 0;
  double _fontSize = 12;

  void Function()? _onPressed;

  CustomOutlinedButton setLabel(String label) {
    _label = label;
    return this;
  }

  CustomOutlinedButton setSizedBoxHeight(double sizedBoxHeight) {
    _sizedBoxHeight = sizedBoxHeight;
    return this;
  }

  CustomOutlinedButton setFontSize(double fontSize) {
    _fontSize = fontSize;
    return this;
  }

  CustomOutlinedButton setOnPressed(void Function()? onPressed) {
    _onPressed = onPressed;
    return this;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: _onPressed,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10),
            foregroundColor: Colors.black,
            side: BorderSide(
                color:
                Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Text(_label,
              style: TextStyle(
                  fontSize: _fontSize,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
        ),
      ],
    );
  }
}
