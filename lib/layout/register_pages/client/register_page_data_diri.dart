// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/component/upload_with_label.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/client/dashboard_client.dart';
import 'package:riasin_app/layout/register_pages/mua/register_page_data_jasa.dart';

class RegisterPageDataDiri extends StatefulWidget {
  const RegisterPageDataDiri({super.key});

  @override
  State<RegisterPageDataDiri> createState() => _RegisterPageDataDiriState();
}

class _RegisterPageDataDiriState extends State<RegisterPageDataDiri> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> kecamatans = [];
  final dio = Dio();
  bool _isLoading = true;
  final _storage = const FlutterSecureStorage();
  TextEditingController _dateController = TextEditingController();

  String name = '';
  String phone = '';
  String ttl = '';
  String gender = '';
  int? kecamatan;

  File? _image;

  Future<Response> getKecamatan() async {
    return await dio.get('$baseUrl/api/kecamatans');
  }

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  void getData() {
    getKecamatan().then((value) {
      // setState(() {
      //   formData.changeKecamatan(value.data[0]['id'].toString());
      // });
      setState(() {
        kecamatans = value.data['data'];
        _isLoading = false;
      });
    });
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _image = File(returnedImage.path);
    });
  }

  Future<Response> createDataDiri(
      String nama, String tanggal_lahir, String jenis_kelamin, int alamat, String nomor_telepon, File foto) async {
    return dio.post(
      '$baseUrl/api/pencari-jasa-mua/register',
      options: Options(
          contentType: 'application/json',
          headers: {'Authorization': "Bearer ${await _checkToken()}"}),
      data: FormData.fromMap({
        'nama': nama,
        'tanggal_lahir': tanggal_lahir,
        'jenis_kelamin': jenis_kelamin,
        'alamat': alamat,
        'nomor_telepon': nomor_telepon,
        'foto': base64Encode(foto.readAsBytesSync()),
      }),
    );
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            LabeledTextField(
                              field: "Nama Lengkap",
                              hintText: 'Masukkan nama lengkap anda',
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama lengkap tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            LabeledTextField(
                              field: "Nomor Telepon",
                              hintText: 'Masukkan nomor telepon anda',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  phone = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nomor telepon tidak boleh kosong';
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Input hanya boleh berupa angka';
                                }
                                if (value[0] != '0') {
                                  return 'Masukkan nomor telepon yg valid';
                                }
                                return null;
                              },
                            ),
                            LabeledTextField(
                              controller: _dateController,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1800),
                                  lastDate: DateTime(2200),
                                ).then((value) {
                                  if (value != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(value);
                                    setState(() {
                                      ttl = formattedDate;
                                      _dateController.text = formattedDate;
                                    });
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tanggal lahir tidak boleh kosong';
                                }
                                if (!RegExp(r'^\d{4}-\d{2}-\d{2}$')
                                    .hasMatch(value)) {
                                  return 'Input harus dalam format yyyy-MM-dd';
                                }
                                return null;
                              },
                              field: "Tanggal Lahir",
                              hintText: 'Masukkan tanggal lahir anda',
                              suffixIcon: Icon(
                                Icons.calendar_today_rounded,
                                color: Color(0xffC55977),
                              ),
                            ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                                validator: (value) => value == null
                                    ? 'Jenis kelamin tidak boleh kosong'
                                    : null,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xffC55977),
                                  size: 40,
                                ),
                                hint: Text('Pilih Jenis Kelamin',
                                    style: TextStyle(
                                      color: Color(0x1B090E61),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(height: 2),
                                  labelStyle: TextStyle(
                                    height: 2,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0x1B090E61),
                                  ),
                                  alignLabelWithHint: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 2),
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red[900]!, width: 4),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red[900]!, width: 4),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 197, 89, 120),
                                      width: 4,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(102, 197, 89, 120),
                                      width: 4,
                                    ),
                                  ),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    gender = newValue!;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                      value: 'L',
                                      child: Text('Laki-Laki')),
                                  DropdownMenuItem(
                                      value: 'P',
                                      child: Text('Perempuan')),
                                ]),
                            SizedBox(height: 40),
                            DropdownButtonFormField<String>(
                                validator: (value) => value == null
                                    ? 'Kecamatan tidak boleh kosong'
                                    : null,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xffC55977),
                                  size: 40,
                                ),
                                hint: Text('Pilih Kecamatan',
                                    style: TextStyle(
                                      color: Color(0x1B090E61),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    )),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(height: 2),
                                  labelStyle: TextStyle(
                                    height: 2,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0x1B090E61),
                                  ),
                                  alignLabelWithHint: true,
                                  floatingLabelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red[900]!, width: 4),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red[900]!, width: 4),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 197, 89, 120),
                                      width: 4,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(102, 197, 89, 120),
                                      width: 4,
                                    ),
                                  ),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    kecamatan = int.parse(newValue!);
                                  });
                                },
                                items: kecamatans
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e['nama_kecamatan']),
                                          value: e['id'].toString(),
                                        ))
                                    .toList()),
                            SizedBox(height: 20),
                            UploadWithLabel(
                                icon: Icon(
                                  Icons.image,
                                  color: Color(0xffC55977),
                                  size: 40,
                                ),
                                hint: 'Upload Foto Profil',
                                onTap: () {
                                  _pickImageFromGallery();
                                },
                                image: _image),
                          ],
                        ),
                        WidgetTombolRegistrasiBawah(
                          nextPageOnTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_image == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Foto profil tidak boleh kosong'),
                                  backgroundColor: Colors.red[800],
                                  behavior: SnackBarBehavior.floating,
                                ));
                                return;
                              }
                              try {
                                log('masuk');
                                Response res = await createDataDiri(name, ttl, gender, kecamatan!, phone, _image!);
                                if(res.data!['status'] == 'success') {
                                  String? token = await _checkToken();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardClient(token: token!,)));
                                }
                              } on DioException catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Terjadi kesalahan, silahkan coba lagi'),
                                  backgroundColor: Colors.red[800],
                                  behavior: SnackBarBehavior.floating,
                                ));
                                log(e.response!.data.toString());
                                return;
                              }
                            }
                          },
                          useNextArrow: false,
                          usePrevButton: false,
                          nextPageName: "Register",
                          previousPageName: "Akun",
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
