import 'package:flutter/material.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/img/logo.png"),
            SizedBox(height: 40),
            Text("Daftar Sebagai"),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {},
                    child: Container(
                        height: 100, width: 100, color: Color(0xFFC55977))),
                SizedBox(width: 30),
                InkWell(
                    onTap: () {},
                    child: Container(
                        height: 100, width: 100, color: Color(0xFFC55977))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
