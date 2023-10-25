import 'package:flutter/material.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:riasin_app/main.dart';

class OrderInClient extends StatelessWidget {
  final String nama;
  final String nomor;
  final String gender;
  final String request;

  OrderInClient(
      {required this.nama,
      required this.nomor,
      required this.gender,
      required this.request});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pemesanan', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child:
         Center(
          child: Column(
            children: [
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
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [ 
                                                  Text('Jasa Dipesan', style: TextStyle(fontStyle: FontStyle.italic,fontSize: 13,)), 
                                                  ]
                                              )
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [ 
                                                  Text('Make Up', style: TextStyle(fontSize: 13,)), 
                                                  ]
                                              )
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [ 
                                                  Text('Banyak Orang', style: TextStyle(fontStyle: FontStyle.italic,fontSize: 13,)), 
                                                  ]
                                              )
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [ 
                                                  Text('2'), 
                                                  ]
                                              )
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10), 
                                        Divider(
                                          height: 1, // Ketebalan garis pemisah
                                          color: primaryColor, // Warna garis pemisah
                                        ),
                                        SizedBox(height: 10), 
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [ 
                                                  Text(
                                                    'Total Harga Jasa',
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: 13,
                                                  )),
                                                  ]
                                              )
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [ 
                                                  Text(
                                                    'Rp 600.000',
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                  )),
                                                  ]
                                              )
                                            ),
                                          ],
                                        ),
                                        
                                    ],)),])
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
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
                                Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text(
                                        'Nama Client',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        '$nama',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10), 
                                      Text(
                                        'Nomor Client',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        '$nomor',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10), 
                                      Text(
                                        'Gender Client',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        '$gender',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10), 
                                      Text(
                                        'Request Tambahan Client',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        '$request',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10), 
                                    ],)),])
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: WidgetTombolRegistrasiBawah(
                      nextPageOnTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardMua(),
                              ));
                        }
                      },
                      usePrevButton: false,
                      useNextArrow: false,
                      nextPageName: "Terima Pesanan",
                      previousPageName: "Detail Pemesanan",
                      colorBackground: primaryColor,
                    ),
                    
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                    margin: EdgeInsets.all(16.0),
                    child: WidgetTombolRegistrasiBawah(
                      nextPageOnTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardMua(),
                              ));
                        }
                      },
                      usePrevButton: false,
                      useNextArrow: false,
                      nextPageName: "Tolak Pesanan",
                      previousPageName: "Detail Pemesanan",
                      colorBackground: Color.fromARGB(0, 255, 255, 255),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    
                    ),
                  ),
                ],
              ),
            ],
          )),
      )
    );
  }
}
