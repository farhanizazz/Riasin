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
    return InkWell(
      onTap: widget.onTap,
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: isPressed ? widget.color.withOpacity(0.5) : widget.color,
        ),
        child: InkWell(
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
      ),
    );
  }
}
