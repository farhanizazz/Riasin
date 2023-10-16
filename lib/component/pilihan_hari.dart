import 'package:flutter/material.dart';

class PilihanHari extends StatelessWidget {
  final String hari;
  final bool isSelected;
  final void Function()? onTap;

  const PilihanHari({
    required this.hari,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                isSelected ? const Color(0xffC55977) : const Color(0xffE1CCD2),
          ),
          width: 60,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                hari,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xffECF8F5)
                        : const Color(0xffC55977)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
