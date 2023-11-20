import 'package:flutter/material.dart';

class InkWellWithAnimation extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Function()? onTap;

  InkWellWithAnimation(
      {required this.color,
      required this.textColor,
      required this.text,
      this.onTap});

  @override
  _InkWellWithAnimationState createState() => _InkWellWithAnimationState();
}

class _InkWellWithAnimationState extends State<InkWellWithAnimation> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: isPressed ? widget.color.withOpacity(0.5) : widget.color,
      ),
      child: InkWell(
        onTap: widget.onTap,
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
        // Dalam Ink, gunakan InkWell yang memiliki child
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isPressed ? Colors.grey : widget.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
