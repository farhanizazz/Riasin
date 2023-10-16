// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:riasin_app/component/upload_with_label.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/register_pages/register_page_pilih_hari.dart';

class RegisterPageDataJasa extends StatefulWidget {
  const RegisterPageDataJasa({super.key});

  @override
  State<RegisterPageDataJasa> createState() => _RegisterPageDataJasaState();
}

class _RegisterPageDataJasaState extends State<RegisterPageDataJasa> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  LabeledTextField(
                      field: "Nama Jasa MUA",
                      hintText: 'Masukkan nama usaha anda'),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xffC55977),
                        size: 40,
                      ),
                      hint: Text('Lokasi Jasa',
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
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[900]!, width: 4),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[900]!, width: 4),
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
                        setState(() {});
                      },
                      items: const [
                        DropdownMenuItem(
                            value: 'Laki-Laki', child: Text('Laki-Laki')),
                        DropdownMenuItem(
                            value: 'Perempuan', child: Text('Perempuan')),
                      ]),
                  SizedBox(height: 30),
                  UploadWithLabel(
                    label: "Foto Profil Jasa",
                    onTap: () {
                      _pickImageFromGallery();
                    },
                  ),
                  SizedBox(height: 30),
                  UploadWithLabel(
                    label: "Foto Profil Jasa",
                  ),
                ],
              ),
              WidgetTombolRegistrasiBawah(
                nextPage: RegisterPilihHari(),
                nextPageName: "Daftar",
                previousPageName: "Data Diri",
                useNextArrow: false,
              )
            ],
          ),
        ),
      )),
    );
  }
}
