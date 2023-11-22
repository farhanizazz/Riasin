import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/Url.dart';


import 'katalog_page.dart';

class EditKatalogJasa extends StatefulWidget {
  const EditKatalogJasa({super.key, required this.id, required this.photoUrl, required this.nama});
  final int id;
  final String photoUrl;
  final String nama;


  @override
  State<EditKatalogJasa> createState() => _EditKatalogJasaState();
}

class _EditKatalogJasaState extends State<EditKatalogJasa> {
  bool _isEdit = false;
  final dio = Dio();
  final _storage = const FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    "Durasi": "",
    "Harga": "",
  };

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Katalog Jasa",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: "katalogJasa${widget.id}",
              child: KatalogJasaItem(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.network(
                        widget.photoUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.nama,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _isEdit
                  ? Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text('Detail Jasa',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isEdit = !_isEdit;
                                });
                              },
                              icon: const Icon(Icons.edit,
                                  color: Color(0xffC55967)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: const Divider(
                            height: 1,
                            color: Color(0xffE1CCD2),
                            endIndent: 10,
                          ),
                        ),
                        Form(
                          key: _formKey,
                            child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tolong masukkan durasi jasa anda';
                                  }
                                  if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                                    return 'Tolong hanya masukkan angka saja';
                                  }
                                },
                                onSaved: (value) {
                                  _formData['Durasi'] = value!;
                                },
                                decoration: InputDecoration(
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  labelStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.3),
                                      fontWeight: FontWeight.bold),
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.3)),
                                  hintText:
                                      "Masukkan lama jasa anda dalam menit",
                                  labelText: "Durasi (Menit)",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10)
                                  .copyWith(bottom: 40),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tolong masukkan harga jasa anda';
                                  }
                                  if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                                    return 'Tolong hanya masukkan angka saja';
                                  }
                                },
                                onSaved: (value) {
                                  _formData['Harga'] = value!;
                                },
                                decoration: InputDecoration(
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  labelStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.3),
                                      fontWeight: FontWeight.bold),
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(0.3)),
                                  hintText: "Masukkan harga jasa anda",
                                  labelText: "Harga ",
                                ),
                              ),
                            ),
                          ],
                        )),

                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text('Detail Jasa',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isEdit = !_isEdit;
                                });
                              },
                              icon: const Icon(Icons.edit,
                                  color: Color(0xffC55967)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: const Divider(
                            height: 1,
                            color: Color(0xffE1CCD2),
                            endIndent: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Durasi: 120 menit",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffC55967),
                                      fontWeight: FontWeight.w600)),
                              Text("Harga: Rp. 350.000",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffC55967),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),

            _isEdit ? Column(
              children: [
                SizedBox(height: 15),
                WidgetTombolRegistrasiBawah(
                  nextPageOnTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_formData);
                      dio
                          .post(
                        "$baseUrl/api/penyedia-jasa-mua/katalog/updatekatalogjasa",
                        data: jsonEncode({
                          "id": widget.id,
                          "durasi": _formData['Durasi'],
                          "harga": _formData['Harga'],
                        }),
                        options: Options(
                          headers: {
                            "Accept": "application/json",
                            "Authorization": 'Bearer ${await _checkToken()}'
                          },
                        ),
                      )
                          .then((value) {
                        print(value.data);
                        Navigator.pop(context);
                      });
                    }
                  },
                  nextPageName: "Simpan",
                  previousPageName: "Simpan",
                  useNextArrow: false,
                  usePrevButton: false,
                ),
              ],
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
