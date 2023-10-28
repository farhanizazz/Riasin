import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/layout/client/dashboard_client.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:riasin_app/layout/register_pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();
  bool _isLoading = false;


  Future<http.Response> loginMUA(String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/logoRiasin.svg"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LabeledTextField(
                      field: 'Email',
                      hintText: "Masukkan email anda",
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if(!value.contains('@')){
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    LabeledTextField(
                      field: 'Password',
                      hintText: "Masukkan password anda",
                      obscureText: true,
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder:(context) => splashscreen()));
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: const Text(
                          "Lupa Password",
                          style: TextStyle(
                              color: Color(0x1B090E4D),
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await loginMUA(emailController.text,
                                      passwordController.text)
                                  .then((value) => {
                                        if (value.statusCode == 200)
                                          {
                                            _storage.write(
                                                key: 'token',
                                                value: jsonDecode(
                                                    value.body)['token']),
                                            if(jsonDecode(value.body)['data']['role_id'] == 2) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashboardMua()))
                                            } else if (jsonDecode(value.body)['data']['role_id'] == 3) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashboardClient(token: jsonDecode(value.body)['token'],)))
                                            }
                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             DashboardMua()))
                                          }
                                        else
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Email atau password salah")))
                                          }
                                      });
                            } on Exception catch (e) {
                              print(e);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFC55977),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: _isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text("Masuk")),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun?",
                        style: TextStyle(
                            color: Color(0x1b090e4d),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                                color: Color(0xffC55977),
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
