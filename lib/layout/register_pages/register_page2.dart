// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:riasin_app/component/labeled_text_field.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';
import 'package:riasin_app/layout/register_pages/register_page3.dart';

class RegisterPageDataDiri extends StatefulWidget {
  const RegisterPageDataDiri({super.key});

  @override
  State<RegisterPageDataDiri> createState() => _RegisterPageDataDiriState();
}

class _RegisterPageDataDiriState extends State<RegisterPageDataDiri> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  LabeledTextField(
                      field: "Nama Lengkap",
                      hintText: 'Masukkan nama lengkap anda'),
                  LabeledTextField(
                      field: "Nomor Telepon",
                      hintText: 'Masukkan nama lengkap anda'),
                  LabeledTextField(
                    controller: _dateController,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime(2200))
                          .then((value) => setState(() => value == null
                              ? {}
                              : _dateController.text =
                                  DateFormat('yyyy-MM-dd').format(value)));
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
                        setState(() {});
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
                nextPage: RegisterPageDataJasa(),
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
