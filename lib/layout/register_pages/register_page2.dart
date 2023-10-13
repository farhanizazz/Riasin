// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:riasin_app/component/labeled_text_field.dart';

class RegisterPageDataDiri extends StatefulWidget {
  const RegisterPageDataDiri({super.key});

  @override
  State<RegisterPageDataDiri> createState() => _RegisterPageDataDiriState();
}

class _RegisterPageDataDiriState extends State<RegisterPageDataDiri> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              LabeledTextField(
                  field: "Nama Lengkap",
                  hintText: 'Masukkan nama lengkap anda'),
              SizedBox(
                height: 20,
              ),
              LabeledTextField(
                  field: "Nama Lengkap",
                  hintText: 'Masukkan nama lengkap anda'),
              SizedBox(
                height: 20,
              ),
              LabeledTextField(
                  field: "Nama Lengkap",
                  hintText: 'Masukkan nama lengkap anda'),
              SizedBox(
                height: 20,
              ),
              LabeledTextField(
                  field: "Nama Lengkap",
                  hintText: 'Masukkan nama lengkap anda'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPageDataDiri(),
                        ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text('Register',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
