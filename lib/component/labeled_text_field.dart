// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String field;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Set? Function(String?)? onSaved;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const LabeledTextField(
      {super.key,
      required this.field,
      required this.hintText,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.onSaved,
      this.suffixIcon,
      this.onTap,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
            onChanged: onChanged,
            onTap: onTap,
            maxLength: 99,
            controller: controller,
            onSaved: onSaved,
            validator: validator != null
                ? (value) => validator!(value)
                : (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
            obscureText: obscureText,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                counterStyle: MaterialStateTextStyle.resolveWith(
                    (states) => TextStyle(color: Colors.transparent)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0x50C55977))),
                labelText: field,
                hintText: '')),
      ],
    );
  }
}
