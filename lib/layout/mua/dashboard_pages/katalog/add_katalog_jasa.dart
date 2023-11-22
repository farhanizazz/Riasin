import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/upload_with_label.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';

class KatalogJasa extends StatefulWidget {
  const KatalogJasa({super.key});

  @override
  State<KatalogJasa> createState() => _KatalogJasaState();
}

class _KatalogJasaState extends State<KatalogJasa> {
  final dio = Dio();
  final _storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  List katalog = [];
  Map data = {
    'kategori_layanan_id': '',
    'nama': '',
    'harga': '',
    'foto': '',
    'deskripsi': '',
    'durasi': '',
  };

  Future<Response> getKatalog() async {
    return dio.get('$baseUrl/api/penyedia-jasa-mua/katalog/kategorilayanan',
        options: Options(headers: {
          'Authorization': 'Bearer ${await _storage.read(key: 'token')}'
        }));
  }

  void getData() {
    getKatalog().then((value) {
      setState(() {
        katalog = value.data['data'];
      });
    });
  }

  void pickImage() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      data['foto'] = File(returnedImage!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Preview MUA",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(bottom: 40, top: 10),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            data['kategori_layanan_id'] = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Kategori layanan harus diisi";
                          }
                        },
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.black.withOpacity(0.3)),
                          hintText: "Masukkan jenis jasa anda",
                          labelText: "Jenis Jasa",
                        ),
                        items: katalog.map((e) {
                          return DropdownMenuItem(
                            child: Text(e['nama']),
                            value: e['id'],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama jasa harus diisi";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            data['nama'] = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.black.withOpacity(0.3)),
                          hintText: "Masukkan nama jasa anda",
                          labelText: "Nama Jasa",
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Harga jasa harus diisi";
                          }
                          if (int.parse(value) < 0) {
                            return 'Tolong masukkan harga yang benar';
                          }
                          if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                            return 'Tolong hanya masukkan angka saja';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            data['harga'] = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.black.withOpacity(0.3)),
                          hintText: "Masukkan harga jasa anda",
                          labelText: "Harga Jasa",
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Durasi jasa harus diisi";
                          }
                          if (int.parse(value) < 0) {
                            return 'Tolong masukkan harga yang benar';
                          }
                          if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                            return 'Tolong hanya masukkan angka saja';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            data['durasi'] = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.black.withOpacity(0.3)),
                          hintText: "Masukkan durasi jasa anda",
                          labelText: "Durasi Jasa",
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Deskripsi jasa harus diisi";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            data['deskripsi'] = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.black.withOpacity(0.3)),
                          hintText: "Masukkan deskripsi jasa anda",
                          labelText: "Deskripsi Jasa",
                        ),
                      ),
                      SizedBox(height: 20),
                      UploadWithLabel(
                        hint: "Upload Foto Jasa",
                        icon: Icon(Icons.upload, color: Color(0xffC55977),),
                        onTap: () {
                          pickImage();
                        },
                        image: data['foto'] == '' ? null : data['foto'],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                WidgetTombolRegistrasiBawah(
                  nextPageOnTap: () async {
                    if(_formKey.currentState!.validate()){
                      if(data['foto'] == ''){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Foto harus diisi'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      try {
                        var formData = FormData.fromMap({
                          'kategori_layanan_id': data['kategori_layanan_id'],
                          'nama': data['nama'],
                          'harga': data['harga'],
                          'deskripsi': data['deskripsi'],
                          'durasi': data['durasi'],
                          'foto': base64Encode(data['foto'].readAsBytesSync()),

                        });
                        var response = await dio.post(
                            '$baseUrl/api/penyedia-jasa-mua/katalog/createkatalogjasa',
                            data: formData,
                            options: Options(headers: {
                              'Authorization':
                                  'Bearer ${await _storage.read(key: 'token')}'
                            }));
                        if (response.data['success'] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(response.data['message']),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(response.data['message']),
                          ));
                          print(response.data);
                        }
                      } on DioException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.response!.data['message'].toString()),
                        ));
                        print(e.response);
                      }
                    }
                  },
                  nextPageName: "Tambah",
                  previousPageName: "Batal",
                  usePrevButton: false,
                  useNextArrow: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
