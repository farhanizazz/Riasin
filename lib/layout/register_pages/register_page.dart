// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/layout/register_pages/register_page2.dart';
import 'package:riasin_app/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  Map<String, String> _formData = {"email": "", "password": ""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/logoRiasin.svg',
              semanticsLabel: 'Logo riasin',
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  LabeledTextField(
                    field: 'Email',
                    hintText: 'Masukkan email anda',
                    onSaved: (value) => {
                      _formData["email"] = value!,
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LabeledTextField(
                    field: 'Password',
                    hintText: 'Masukkan password anda',
                    obscureText: true,
                    controller: _passwordController,
                    onSaved: (value) => {
                      _formData["password"] = value!,
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LabeledTextField(
                    field: 'Repeat Password',
                    hintText: 'Ulangi password anda',
                    obscureText: true,
                    controller: _repeatPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value != _passwordController.text) {
                        return 'Password tidak sama';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          child: Text(
                            'Lupa Password',
                            style: TextStyle(
                                color: Color.fromARGB(70, 27, 9, 14),
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {})),
                  SizedBox(
                    height: 10,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                            color: Color.fromARGB(70, 27, 9, 14),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 5),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xffC55977),
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {})
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
