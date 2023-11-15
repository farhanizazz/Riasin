// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:riasin_app/main.dart';

class ProfileRead extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xFFC55977),
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
                                        'Farhan Iz',
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
                                        '0812345678',
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
                                        '17 Agustus 1945',
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
                                        'Laki-laki',
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
            ],
          )),
      )
    );
  }
}
