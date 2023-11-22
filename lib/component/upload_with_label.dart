// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

class UploadWithLabel extends StatelessWidget {
  const UploadWithLabel(
      {super.key, this.label, this.image, this.onTap, required this.icon, required this.hint});
  final String? label;
  final File? image;
  final void Function()? onTap;
  final Icon icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label == null ? SizedBox() : Align(
          alignment: Alignment.centerLeft,
          child: Text(label!,
              style: TextStyle(
                color: Color(0x1B090E61),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 158,
          child: Material(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffE1CCD2),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon,
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            hint,
                            style: TextStyle(
                              color: Color(0xffC55977),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          )
                        ],
                      )
                    : Image.file(image!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
