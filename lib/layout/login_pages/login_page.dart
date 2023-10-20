import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/layout/register_pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Column(
                children: [
                  LabeledTextField(
                      field: 'Email', hintText: "Masukkan email anda"),
                  LabeledTextField(
                    field: 'Password',
                    hintText: "Masukkan password anda",
                    obscureText: true,
                  ),
                ],
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC55977),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text("Masuk")),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun?",
                        style: TextStyle(
                            color: Color(0xff1b090e4d),
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
                                    builder: (context) => const RegisterPage()));
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
