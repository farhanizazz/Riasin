import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String field;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Set? Function(String?)? onSaved;

  const LabeledTextField({
    super.key,
    required this.field,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(field,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
        ),
        const SizedBox(height: 9),
        TextFormField(
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
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(57))),
          ),
        ),
      ],
    );
  }
}
