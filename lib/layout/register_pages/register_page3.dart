// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/register_pages/register_page3.dart';
import 'package:riasin_app/layout/register_pages/register_page_pilih_hari.dart';
import 'package:riasin_app/providers/form_data_provider.dart';

import '../../component/upload_with_label.dart';

class RegisterPageDataJasa extends StatefulWidget {
  const RegisterPageDataJasa({super.key});

  @override
  State<RegisterPageDataJasa> createState() => _RegisterPageDataDiriState();
}

class _RegisterPageDataDiriState extends State<RegisterPageDataJasa> {
  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  @override
  void initState() {
    final FormData formData = Provider.of<FormData>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FormData formData = Provider.of<FormData>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
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
                    onChanged: formData.changeNamaLengkap,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    isDense: true,
                      validator: (value) => value == null
                          ? 'Jenis kelamin tidak boleh kosong'
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
                        setState(() {
                          formData.changeJenisKelamin(newValue!);
                        });
                      },
                      items: [
                        DropdownMenuItem(
                            value: 'Laki-Laki', child: Text('Laki-Laki')),
                        DropdownMenuItem(
                            value: 'Perempuan', child: Text('Perempuan')),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
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
                nextPageOnTap: () {
                  if (_formKey.currentState!.validate()) {
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
