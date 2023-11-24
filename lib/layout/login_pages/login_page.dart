import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/layout/client/dashboard_client.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:riasin_app/layout/register_pages/client/register_page.dart';

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
  bool _isObscure = true;

  final dio = Dio();

  Future<Response> loginMUA(String email, String password) {
    return dio.post('$baseUrl/api/login',
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: FormData.fromMap({
        "email": email,
        "password": password,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
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
                    height: 150,
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
                            if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        ),
                        LabeledTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: _isObscure
                                ? const Icon(
                                    Icons.visibility,
                                    color: Color(0xffC55977),
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xffC55977),
                                  ),
                          ),
                          field: 'Password',
                          hintText: "Masukkan password anda",
                          obscureText: _isObscure,
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
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: _isLoading ? null :  () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await loginMUA(emailController.text,
                                          passwordController.text)
                                      .then((value) => {
                                            _isLoading = false,
                                            if (value.data['status'])
                                              {
                                                _storage.write(
                                                    key: 'token',
                                                    value: value.data['token']),
                                                if (value.data['data']
                                                        ['role_id'] ==
                                                    2)
                                                  {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DashboardMua()))
                                                  }
                                                else if (value.data['data']['role_id'] ==
                                                    3)
                                                  {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DashboardClient(
                                                                  token: value.data['token'],
                                                                )))
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
                                                            "Email atau password salah"))),
                                                setState(() {
                                                  _isLoading = false;
                                                })
                                              }
                                          });
                                } on DioException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(e.toString())));
                                  log(e.response.toString());
                                }
                              }
                            },
                            style:ButtonStyle(
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
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Masuk")),
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
        ),
      ),
    );
  }
}
