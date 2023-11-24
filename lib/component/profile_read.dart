import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/layout/login_pages/login_page.dart';
import 'package:riasin_app/main.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.imagePath,
    required this.muaName,
    required this.muaPhone,
    required this.muaBorn,
    required this.muaGender,
  });

  final String imagePath;
  final String muaName;
  final String muaPhone;
  final String muaBorn;
  final String muaGender;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _loading = false;
  final dio = Dio();
  final _storage = const FlutterSecureStorage();

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: const Color(0xFFC55977),
        ),
        body: ListView(children: <Widget>[
          Stack(children: <Widget>[
            Container(
              color: const Color(0xFFC55977),
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 12,
            ),
            SingleChildScrollView(
              child: Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              widget.imagePath,
                              fit: BoxFit.cover,
                            )),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        'Data Diri',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: primaryColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Row(
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          'Nama Lengkap',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                  255, 197, 89,
                                                                  120)),
                                                        ),
                                                        Text(
                                                          widget.muaName,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'Nomor Telepon',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                  255, 197, 89,
                                                                  120)),
                                                        ),
                                                        Text(
                                                          widget.muaPhone,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'Tanggal Lahir',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                  255, 197, 89,
                                                                  120)),
                                                        ),
                                                        Text(
                                                          widget.muaBorn,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'Gender',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                  255, 197, 89,
                                                                  120)),
                                                        ),
                                                        Text(
                                                          widget.muaGender,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                        SizedBox(height: 10),
                                                      ],)),
                                              ])
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              overlayColor: _loading
                                  ? MaterialStateProperty.all<Color>(
                                  Colors.transparent)
                                  : null,
                              backgroundColor: _loading
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
                            onPressed: _loading ? null : () async {
                              setState(() => _loading = true);
                              try {
                                Response res = await dio.post(
                                    '$baseUrl/api/logout', options: Options(
                                    headers: {
                                      'Authorization': 'Bearer ${await _checkToken()}'
                                    }));
                                if (res.data['status'] == true) {
                                  _storage.delete(key: 'token').then((value) =>
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) => const LoginPage())));
                                }
                              } on DioException catch (e) {
                                log(e.response.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.response!.data['message']),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: _loading ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ) : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Logout'),
                                SizedBox(width: 24),
                                Icon(Icons.exit_to_app),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  )),
            )
          ])
        ])
    );
  }
}
