import 'package:flutter/material.dart';
import 'package:login/splash_screen.dart';

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
          padding: EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/img/logo.png"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC55977))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC55977))),
                  labelStyle: TextStyle(color: Color(0xFFC55977)),
                  labelText: 'E-Mail',
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC55977))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC55977))),
                  labelStyle: TextStyle(color: Color(0xFFC55977)),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder:(context) => splashscreen()));
                  }, child: Text("Lupa Password")),
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC55977),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                    child: Text("Masuk")),
              )
            ],
          )),
    );
  }
}
