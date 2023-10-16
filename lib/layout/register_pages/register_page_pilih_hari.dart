// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:riasin_app/component/pilihan_hari.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
        child: Column(
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
                      style: TextStyle(color: Color(0xffC55977), fontSize: 50))
                ])),
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

class Page1 extends StatefulWidget {
  const Page1({
    super.key,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List hari = [];

  addHari(String hari) {
    setState(() {
      if (this.hari.contains(hari)) {
        this.hari.remove(hari);
        return;
      }
      this.hari.add(hari);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffE9ECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pilih hari yang tersedia untuk menerima orderan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffC55977),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PilihanHari(
                        hari: "Senin",
                        isSelected: hari.contains('Senin'),
                        onTap: (() {
                          addHari("Senin");
                        }),
                      ),
                      PilihanHari(
                        hari: "Selasa",
                        isSelected: hari.contains('Selasa'),
                        onTap: (() {
                          addHari("Selasa");
                        }),
                      ),
                      PilihanHari(
                        hari: "Rabu",
                        isSelected: hari.contains('Rabu'),
                        onTap: (() {
                          addHari("Rabu");
                        }),
                      ),
                      PilihanHari(
                        hari: "Kamis",
                        isSelected: hari.contains('Kamis'),
                        onTap: (() {
                          addHari("Kamis");
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PilihanHari(
                          hari: "Jumat",
                          isSelected: hari.contains("Jumat"),
                          onTap: (() {
                            addHari("Jumat");
                          }),
                        ),
                        PilihanHari(
                          hari: "Sabtu",
                          isSelected: hari.contains('Sabtu'),
                          onTap: (() {
                            addHari("Sabtu");
                          }),
                        ),
                        PilihanHari(
                          hari: "Minggu",
                          isSelected: hari.contains('Minggu'),
                          onTap: (() {
                            addHari("Minggu");
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffE9ECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Masukkan jumlah pelanggan yang bisa Anda layani per harinya",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffC55977),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffE1CCD2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Color(0xffC55977),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffE9ECEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Masukkan jumlah pelanggan yang bisa Anda layani per harinya",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xffC55977),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffE1CCD2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Color(0xffC55977),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
