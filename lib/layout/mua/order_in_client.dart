// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:riasin_app/main.dart';

class OrderInClient extends StatefulWidget {
  final String nama;
  final String nomor;
  final String gender;
  final String request;
  final int id;

  const OrderInClient(
      {super.key,
      required this.nama,
      required this.nomor,
      required this.gender,
      required this.request,
      required this.id});

  @override
  State<OrderInClient> createState() => _OrderInClientState();
}

class _OrderInClientState extends State<OrderInClient> {
  final _storage = const FlutterSecureStorage();
  final dio = Dio();
  bool _isLoading = true;
  final formatter = NumberFormat("#,##,000");

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  Future<Response<Map>> getDetailPemesanan() async {
    Response<Map<String, dynamic>> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/pemesanan/detailpemesanan/${widget.id}',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }

  Map<String, dynamic> data = {};

  void fetchData() async {
    try {
      final resData = await getDetailPemesanan();
      setState(() {
        data = resData.data!['data'][0];
        _isLoading = false;
      });
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.response.toString()),
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECF8F5),
        appBar: AppBar(
          title: Text('Detail Pemesanan',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Center(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Card(
                          elevation: 0,
                          color: Color(0xFFFFFFFF),
                          margin: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                    Text('Jasa Dipesan',
                                                        style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 13,
                                                        )),
                                                  ])),
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                    Text(data['nama']!,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                        )),
                                                  ])),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                    Text('Banyak Orang',
                                                        style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 13,
                                                        )),
                                                  ])),
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                    Text(data['jumlah']!),
                                                  ])),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                            height: 1,
                                            // Ketebalan garis pemisah
                                            color:
                                                primaryColor, // Warna garis pemisah
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                    Text('Total Harga Jasa',
                                                        style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 13,
                                                        )),
                                                  ])),
                                              Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                    Text('Rp. ${formatter.format(int.parse(data['total_harga']))}',
                                                        style: TextStyle(
                                                          color: primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13,
                                                        )),
                                                  ])),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Card(
                          color: Color(0xFFFFFFFF),
                          elevation: 0,
                          margin: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Data Diri Pemesan',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1, // Ketebalan garis pemisah
                                color: primaryColor, // Warna garis pemisah
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nama Client',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 197, 89, 120)),
                                          ),
                                          Text(
                                            data['nama_pemesan'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Nomor Client',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 197, 89, 120)),
                                          ),
                                          Text(
                                            data['nomor_telepon_pemesan'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Gender Client',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 197, 89, 120)),
                                          ),
                                          Text(
                                            data['gender_pemesan'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Request Tambahan Client',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 197, 89, 120)),
                                          ),
                                          Text(
                                            data['keterangan'],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )),
                                    ])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: WidgetTombolRegistrasiBawah(
                              nextPageOnTap: () async {
                                  dio.get(
                                      '$baseUrl/api/penyedia-jasa-mua/pemesanan/acceptpemesanan/${widget.id}',
                                      options: Options(headers: {
                                      'Authorization':
                                      'Bearer ${await _checkToken()}'
                                      })).then((value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardMua())))
                                      .catchError((e) =>
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(e.response.toString()),
                                      )));
                              },
                              usePrevButton: false,
                              useNextArrow: false,
                              nextPageName: "Terima Pesanan",
                              previousPageName: "Detail",
                              colorBackground: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(16.0),
                            child: WidgetTombolRegistrasiBawah(
                              nextPageOnTap: () async {
                                dio.get(
                                        '$baseUrl/api/penyedia-jasa-mua/pemesanan/declinepemesanan/${widget.id}',
                                        options: Options(headers: {
                                          'Authorization':
                                              'Bearer ${await _checkToken()}'
                                        })).then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardMua())))
                                    .catchError((e) =>
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text(e.response.toString()),
                                        )));
                              },
                              usePrevButton: false,
                              useNextArrow: false,
                              nextPageName: "Tolak Pesanan",
                              previousPageName: "Detail Pemesanan",
                              colorBackground: Color.fromARGB(0, 255, 255, 255),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ));
  }
}
