import 'package:flutter/material.dart';

class SelectMultipleChip extends StatelessWidget {
  const SelectMultipleChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onPressed,
  });

  final String label;
  final bool selected;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xffC55977),
        ),
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: selected ? const Color(0xffC55977) : null,
      side: BorderSide(
        color: selected ? Colors.transparent : Color(0xffC55977),
        width: 1.5,
      ),
    );
  }
}