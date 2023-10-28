// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/register_pages/register_page_pilih_hari.dart';
import 'package:riasin_app/providers/form_data_provider.dart';
import 'package:dio/dio.dart' as Dio;

import '../../component/upload_with_label.dart';

class RegisterPageDataJasa extends StatefulWidget {
  const RegisterPageDataJasa({super.key});

  @override
  State<RegisterPageDataJasa> createState() => _RegisterPageDataDiriState();
}

class _RegisterPageDataDiriState extends State<RegisterPageDataJasa> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaMUAController = TextEditingController();
  TextEditingController _kecamatanController = TextEditingController();

  late FormData formData;

  final dio = Dio.Dio();

  Future<Dio.Response> getKecamatan() async {
    return await dio.get('$baseUrl/api/kecamatans');
  }

  List<dynamic> kecamatans = [];
  bool _isLoading = true;

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

    setState(() {
      formData.changeProfilePicture(File(returnedImage!.path));
    });
  }

  Future _pickPDFPortofolio() async {
    FilePickerResult? returnedFile = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (returnedFile != null) {
      setState(() {
        formData
            .changePortofolio(returnedFile.paths.map((e) => File(e!)).toList());
      });
    }
  }

  @override
  void initState() {
    formData = Provider.of<FormData>(context, listen: false);
    getData();

    super.initState();
    _namaMUAController = TextEditingController(text: formData.namaMUA);
    _kecamatanController = TextEditingController(text: formData.kecamatan);
  }

  @override
  void dispose() {
    _namaMUAController.dispose();
    _kecamatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FormData formData = Provider.of<FormData>(context);

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
                              field: "Nama Jasa",
                              hintText: 'Masukkan nama jasa anda',
                              controller: _namaMUAController,
                              onChanged: formData.changeNamaMUA,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama lengkap tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
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
                                    formData.changeKecamatan(newValue!);
                                  });
                                },
                                items: kecamatans
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e['nama_kecamatan']),
                                          value: e['id'].toString(),
                                        ))
                                    .toList()),
                            SizedBox(
                              height: 20,
                            ),
                            UploadWithLabel(
                              hint: "Upload Foto Profil Jasa",
                              label: "Foto Profil Jasa",
                              onTap: () {
                                _pickImageFromGallery();
                              },
                              image: formData.profilePicture,
                              icon: Icon(
                                Icons.image,
                                color: Color(0xffC55977),
                                size: 40,
                              ),
                            ),
                            SizedBox(height: 30),
                            UploadWithLabel(
                              label: "Portofolio Jasa",
                              onTap: () {
                                _pickPDFPortofolio();
                              },
                              hint: "Upload PDF Portofolio",
                              icon: Icon(
                                Icons.file_copy,
                                color: Color(0xffC55977),
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        WidgetTombolRegistrasiBawah(
                          nextPageOnTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (formData.profilePicture == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Foto profil tidak boleh kosong'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              if (formData.pdfPortfolio == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Portofolio tidak boleh kosong'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPilihHari(),
                                  ));
                            }
                          },
                          nextPageName: "Data Jasa",
                          previousPageName: "Data Diri",
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
