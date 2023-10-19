// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/register_pages/register_page3.dart';
import 'package:riasin_app/providers/form_data_provider.dart';

class RegisterPageDataDiri extends StatefulWidget {
  const RegisterPageDataDiri({super.key});

  @override
  State<RegisterPageDataDiri> createState() => _RegisterPageDataDiriState();
}

class _RegisterPageDataDiriState extends State<RegisterPageDataDiri> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    final FormData formData = Provider.of<FormData>(context, listen: false);

    super.initState();
    _nameController = TextEditingController(text: formData.namaLengkap);
    _phoneController = TextEditingController(text: formData.nomorTelepon);
    _dateController = TextEditingController(text: formData.tanggalLahir);
    _genderController = TextEditingController(text: formData.jenisKelamin);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _dateController.dispose();
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
                    controller: _nameController,
                    onChanged: formData.changeNamaLengkap,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  LabeledTextField(
                    field: "Nomor Telepon",
                    hintText: 'Masukkan nama lengkap anda',
                    controller: _phoneController,
                    onChanged: formData.changeNomorTelepon,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor telepon tidak boleh kosong';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Input hanya boleh berupa angka';
                      }
                      return null;
                    },
                  ),
                  LabeledTextField(
                    onChanged: formData.changeTanggalLahir,
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
                            _dateController.text = formattedDate;
                            formData.changeTanggalLahir(formattedDate);
                          });
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal lahir tidak boleh kosong';
                      }
                      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                        return 'Input must be in the format yyyy-MM-dd';
                      }
                      return null;
                    },
                    field: "Tanggal Lahir",
                    hintText: 'Masukkan nama lengkap anda',
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
                ],
              ),
              WidgetTombolRegistrasiBawah(
                nextPageOnTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPageDataJasa(),
                        ));
                  }
                },
                usePrevButton: false,
                nextPageName: "Data Jasa",
                previousPageName: "Akun",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
