// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:riasin_app/layout/register_pages/mua/register_pilih_hari_pelanggan_kategori/page_1.dart';
import 'package:riasin_app/layout/register_pages/mua/register_pilih_hari_pelanggan_kategori/page_2.dart';
import 'package:riasin_app/layout/register_pages/mua/register_pilih_hari_pelanggan_kategori/page_3.dart';
import 'package:riasin_app/providers/form_data_provider.dart';
import 'package:riasin_app/Url.dart';

import 'package:dio/dio.dart' as dio;

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
    Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text('Mohon tunggu sebentar')
        ],
      ),
    ),
  ];

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  final _storage = const FlutterSecureStorage();
  int currentPage = 0;
  double registerProgress = 0.3;

  late FormData _formData;

  @override
  void initState() {
    _formData = Provider.of<FormData>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentPage = 0;
    registerProgress = 0.3;
  }

  @override
  Widget build(BuildContext context) {
    log(currentPage.toString());
    log(_formData.jumlahOrderan);
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
            currentPage == 3
                ? SizedBox()
                : Row(
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
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xffD5F0E9)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  elevation:
                                      MaterialStateProperty.all<double>(0.0),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Colors.transparent),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size.fromHeight(60)),
                                ),
                                child: const Text('Sebelumnya',
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
                          onPressed: currentPage == 2
                              ? () async {
                                  setState(() {
                                    currentPage++;
                                  });
                                  try {
                                    List<String> pdfBase64 = [];
                                    for (var file in _formData.pdfPortfolio!) {
                                      pdfBase64.add(
                                          base64Encode(file.readAsBytesSync()));
                                    }
                                    print(_formData.tanggalLahir);
                                    await dio.Dio()
                                        .post(
                                            "$baseUrl/api/penyedia-jasa-mua/register",
                                            data: {
                                              "nama": _formData.namaLengkap,
                                              "nomor_telepon":
                                                  _formData.nomorTelepon,
                                              "tanggal_lahir":
                                                  _formData.tanggalLahir,
                                              "jenis_kelamin":
                                                  _formData.jenisKelamin,
                                              "nama_jasa_mua":
                                                  _formData.namaMUA,
                                              "lokasi_jasa_mua":
                                                  _formData.kecamatan,
                                              "foto": base64Encode(_formData
                                                  .profilePicture!
                                                  .readAsBytesSync()),
                                              "kapasitas_pelanggan_per_hari":
                                                  _formData.jumlahOrderan,
                                              "hari_ketersediaan":
                                                  _formData.hari.toString(),
                                              "kategori_layanan":
                                                  _formData.kategori.toString(),
                                              "portofolio": pdfBase64,
                                            },
                                            options: dio.Options(
                                                contentType: 'application/json',
                                                headers: {
                                                  'Authorization':
                                                      "Bearer ${await _checkToken()}"
                                                }))
                                        .then((value) => {
                                          _formData.reset(),
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashboardMua()),
                                                  (route) => false)
                                            });
                                  } on dio.DioException catch (e) {
                                    log(e.response.toString());
                                  }
                                }
                              : () {
                                  if (currentPage == 0) {
                                    if (_formData.hari.length == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Pilih minimal 1 hari'),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    } else {
                                      setState(() {
                                        registerProgress += 0.4;
                                        currentPage++;
                                      });
                                    }
                                  } else if (currentPage == 1) {
                                    if (_formData.jumlahOrderan == '' ||
                                        _formData.jumlahOrderan == '0') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text('Masukkan jumlah orderan'),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    } else {
                                      setState(() {
                                        registerProgress += 0.4;
                                        currentPage++;
                                      });
                                    }
                                  } else if (currentPage == 2) {
                                    if (_formData.kategori.length == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text('Pilih minimal 1 kategori'),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    } else {
                                      setState(() {
                                        registerProgress += 0.4;
                                        currentPage++;
                                      });
                                    }
                                  }
                                },
                          // try {
                          //   List<String> pdfBase64 = [];
                          //   for (var file in _formData.pdfPortfolio!) {
                          //     pdfBase64.add(base64Encode(file.readAsBytesSync()));
                          //   }
                          //   print(_formData.tanggalLahir);
                          //   await dio.Dio()
                          //       .post(
                          //           "$baseUrl/api/penyedia-jasa-mua/register",
                          //           data: {
                          //             "nama": _formData.namaLengkap,
                          //             "nomor_telepon": _formData.nomorTelepon,
                          //             "tanggal_lahir": _formData.tanggalLahir,
                          //             "jenis_kelamin": _formData.jenisKelamin,
                          //             "nama_jasa_mua": _formData.namaMUA,
                          //             "lokasi_jasa_mua": _formData.kecamatan,
                          //             "foto": base64Encode(_formData.profilePicture!
                          //                 .readAsBytesSync()),
                          //             "kapasitas_pelanggan_per_hari":
                          //                 _formData.jumlahOrderan,
                          //             "hari_ketersediaan":
                          //                 _formData.hari.toString(),
                          //             "kategori_layanan":
                          //                 _formData.kategori.toString(),
                          //             "portofolio": pdfBase64,
                          //           },
                          //           options: dio.Options(
                          //               contentType: 'application/json',
                          //               headers: {
                          //                 'Authorization':
                          //                     "Bearer ${await _checkToken()}"
                          //               }))
                          //       .then((value) => {
                          //             Navigator.pushAndRemoveUntil(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) => DashboardMua()), (route) => false)
                          //           });
                          // } on dio.DioException catch (e) {
                          //   log(e.response.toString());
                          // }

                          style: ButtonStyle(
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
                          child: const Text('Selanjutnya',
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
