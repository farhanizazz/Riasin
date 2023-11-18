import 'package:flutter/material.dart';
import 'package:riasin_app/main.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';

class ProfileRead extends StatelessWidget {
  const ProfileRead({
      super.key,
      required this.imagePath,
      required this.muaName,
      required this.muaPhone,
      required this.muaBorn,
      required this.muaGender,
      required this.onTap,
    });

    final String imagePath;
    final String muaName;
    final String muaPhone;
    final String muaBorn;
    final String muaGender;
    final Function()? onTap;

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
            height: MediaQuery.of(context).size.height / 12,
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
                          imagePath,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Text(
                                            'Nama Lengkap',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 197, 89, 120)),
                                          ),
                                          Text(
                                            muaName,
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.black),
                                          ),
                                          SizedBox(height: 10), 
                                          Text(
                                            'Nomor Telepon',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 197, 89, 120)),
                                          ),
                                          Text(
                                            muaPhone,
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.black),
                                          ),
                                          SizedBox(height: 10), 
                                          Text(
                                            'Tanggal Lahir',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 197, 89, 120)),
                                          ),
                                          Text(
                                            muaBorn,
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.black),
                                          ),
                                          SizedBox(height: 10), 
                                          Text(
                                            'Gender',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 197, 89, 120)),
                                          ),
                                          Text(
                                            muaGender,
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onTap,
                        child: Row(
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
