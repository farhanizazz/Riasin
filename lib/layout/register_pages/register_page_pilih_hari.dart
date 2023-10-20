// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:riasin_app/layout/register_pages/register_pilih_hari_pelanggan_kategori/page_1.dart';
import 'package:riasin_app/layout/register_pages/register_pilih_hari_pelanggan_kategori/page_2.dart';
import 'package:riasin_app/layout/register_pages/register_pilih_hari_pelanggan_kategori/page_3.dart';

class RegisterPilihHari extends StatefulWidget {
  RegisterPilihHari({super.key});

  @override
  State<RegisterPilihHari> createState() => _RegisterPilihHariState();
}

class _RegisterPilihHariState extends State<RegisterPilihHari> {
  List pageRegistrasi = [
    Page1(),
    Page2(),
    Page3(),
  ];
  int currentPage = 0;
  double registerProgress = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                LinearProgressIndicator(
                  value: registerProgress,
                  backgroundColor: Color(0xffD5F0E9),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: Color(0xff030806),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                      TextSpan(
                          text:
                              'Tinggal beberapa langkah lagi untuk menjadi partner '),
                      TextSpan(
                          text: '\nRiasin',
                          style: TextStyle(letterSpacing: -1, fontSize: 50)),
                      TextSpan(
                          text: '.',
                          style:
                              TextStyle(color: Color(0xffC55977), fontSize: 50))
                    ])),
              ],
            ),
            pageRegistrasi[currentPage],
            Row(
              children: [
                registerProgress > 0.4
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              registerProgress -= 0.4;
                              currentPage--;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffD5F0E9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                          child: const Text('Register',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff030806),
                              )),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: registerProgress > 0.4 ? 36 : 0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      currentPage < pageRegistrasi.length - 1
                          ? setState(() {
                              registerProgress += 0.4;
                              currentPage++;
                            })
                          : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPilihHari()));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(0.0),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size.fromHeight(60)),
                    ),
                    child: const Text('Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
