import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/layout/login_pages/login_page.dart';
import 'package:riasin_app/layout/register_pages/register_page2.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool _isLoading = false;
  String id = '';
  String? value;

  final Map<String, String> _formData = {
    "email": "",
    "password": "",
    "confirm_password": ""
  };

  Map<String, dynamic> errors = {
    "email": "",
    "password": "",
    "confirm_password": ""
  };

  Future<http.Response> createMUA(
      String email, String password, String confirmPassword) {
    return http.post(
      Uri.parse('https://riasinajah.my.id/public/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "role_id": 2,
      }),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              SvgPicture.asset(
                'assets/svg/logoRiasin.svg',
                semanticsLabel: 'Logo riasin',
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    const SizedBox(
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
                    const SizedBox(
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
                        onSaved: (value) => {
                              _formData["confirm_password"] = value!,
                            }),
                    const SizedBox(
                      height: 50,
                    ),
                    // Align(
                    //     alignment: Alignment.centerRight,
                    //     child: TextButton(
                    //         style: ButtonStyle(
                    //           overlayColor: MaterialStateProperty.all<Color>(
                    //               Colors.transparent),
                    //         ),
                    //         child: Text(
                    //           'Lupa Password',
                    //           style: TextStyle(
                    //               color: Color.fromARGB(70, 27, 9, 14),
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //         onPressed: () {})),
                    Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            child: const Text(
                              'Daftar sebagai Pencari MUA',
                              style: TextStyle(
                                  color: Color.fromARGB(70, 27, 9, 14),
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {})),
                    ElevatedButton(
                        onPressed: () {
                          if (_isLoading == false) {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = !_isLoading;
                              });
                              _formKey.currentState!.save();
                              createMUA(
                                      _formData['email']!,
                                      _formData['password']!,
                                      _formData['confirm_password']!)
                                  .then((value) async => {
                                        setState(() {
                                          _isLoading = !_isLoading;
                                        }),
                                        if (value.statusCode == 201)
                                          {
                                            print('berhasil'),
                                            await _storage
                                                .write(
                                                    key: 'token',
                                                    value: jsonDecode(
                                                        value.body)['token'])
                                                .then((value) => {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const RegisterPageDataDiri()))
                                                    }),
                                          }
                                        else
                                          {
                                            errors = jsonDecode(
                                                value.body)['message'],
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(errors['email'] !=
                                                      null
                                                  ? errors['email'][0]
                                                  : errors['password'] != null
                                                      ? errors['password'][0]
                                                      : errors[
                                                              'confirm_password']
                                                          [0]),
                                            ))
                                          }
                                      });
                            }
                          } else {
                            null;
                          }
                        },
                        style: ButtonStyle(
                          overlayColor: _isLoading
                              ? MaterialStateProperty.all<Color>(
                                  Colors.transparent)
                              : null,
                          backgroundColor: _isLoading
                              ? MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 192, 125, 144))
                              : MaterialStateProperty.all<Color>(
                                  const Color(0xffC55977)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          shadowColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size.fromHeight(60)),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ))),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                              color: Color.fromARGB(70, 27, 9, 14),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Color(0xffC55977),
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            })
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
