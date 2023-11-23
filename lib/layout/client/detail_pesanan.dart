import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/inkwell_animation.dart';

class DetailPesanan extends StatefulWidget {
  const DetailPesanan(
      {super.key,
      required this.layanan_id,
      required this.jumlah,
      required this.tanggal, required this.total, required this.idMua, required this.namaJasa});

  final int layanan_id;
  final int jumlah;
  final String tanggal;
  final int total;
  final int idMua;
  final String namaJasa;

  @override
  State<DetailPesanan> createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  @override
  String namaLengkap = '';
  String nomorTelepon = '';
  String gender = '';
  String deskripsi = '';
  var formatter = NumberFormat('#,###');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final dio = Dio();

  final _storage = const FlutterSecureStorage();

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: const Color(0xFFECF8F4),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(top: 50, right: 24, left: 24),
              child: Column(children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Jasa Dipesan"),
                                Text(widget.namaJasa),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Banyak Orang"),
                                Text(widget.jumlah.toString()),
                              ],
                            ),
                            Divider(color: Color(0xffE1CCD2)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Harga Jasa",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFC55977))),
                                Text("Rp. ${formatter.format(widget.total)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFFC55977))),
                              ],
                            ),
                          ],
                        ))),
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Data Diri Pemesan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFFC55977))),
                              const SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama Lengkap tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    namaLengkap = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: "Nama Lengkap",
                                    labelStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nomor Telepon tidak boleh kosong';
                                  }
                                  if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                                    return 'Nomor Telepon tidak valid';
                                  }
                                  if (value[0] != '0') {
                                    return 'Nomor Telepon tidak valid';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    nomorTelepon = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Nomor Telepon",
                                    labelStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              const SizedBox(height: 20),
                              DropdownButtonFormField(
                                validator: (value) {
                                  if (value == '' || value == null) {
                                    return 'Gender tidak boleh kosong';
                                  }
                                  return null;
                                },
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        gender = value;
                                      });
                                    } else {}
                                  },
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.3),
                                        fontWeight: FontWeight.bold),
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.3)),
                                    labelText: "Gender",
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Laki-Laki"),
                                      value: "L",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Perempuan"),
                                      value: "P",
                                    ),
                                  ]),
                              const SizedBox(height: 20),
                              // TextField(
                              //   controller: _descriptionController,
                              //   maxLines: 8,
                              //   decoration: InputDecoration(
                              //     hintText: "Keterangan atau request tambahan",
                              //     hintStyle: const TextStyle(
                              //       fontSize: 16,
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Theme
                              //                 .of(context)
                              //                 .colorScheme
                              //                 .primary)),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //             color: Theme
                              //                 .of(context)
                              //                 .colorScheme
                              //                 .primary)),
                              //   ),
                              // )
                              SizedBox(
                                height: 150,
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.top,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: 'Request Tambahan',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xffDFC0C9),
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xffDFC0C9),
                                        width: 3,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      deskripsi = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ))),
              ]),
            )),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: InkWellWithAnimation(
                color: Colors.pink,
                textColor: Colors.white,
                text: 'Pesan MUA',
                onTap: () async {
                  // CoolAlert.show(
                  //     context: context,
                  //     type: CoolAlertType.error,
                  //     text: "Pesanan penuh pada tanggal yang dipilih!");
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  print({
                    'id': widget.idMua,
                    'tanggal_pemesanan': widget.tanggal,
                    'nama_pemesan': namaLengkap,
                    'nomor_telepon_pemesan': nomorTelepon,
                    'gender_pemesan': gender,
                    'keterangan': deskripsi,
                    'layanan_id': widget.layanan_id,
                    'jumlah': widget.jumlah,
                    'total_harga': widget.total,
                  }.toString());
                  try {
                    Response res = await dio.post('${baseUrl}/api/pencari-jasa-mua/create-pemesanan',
                        options: Options(
                          headers: {
                            'Authorization': 'Bearer ${await _checkToken()}'
                          },
                        ),
                        data: {
                          'id': widget.idMua,
                          'tanggal_pemesanan': widget.tanggal,
                          'nama_pemesan': namaLengkap,
                          'nomor_telepon_pemesan': nomorTelepon,
                          'gender_pemesan': gender,
                          'keterangan': deskripsi,
                          'layanan_id': widget.layanan_id,
                          'jumlah': widget.jumlah,
                          'total_harga': widget.total,
                        });
                    if (res.data['status'] == 'success') {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text: "Berhasil memesan MUA!",
                          onConfirmBtnTap: () {
                            Navigator.pop(context);
                          });
                    } else {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: res.data['message'].toString());
                    }
                  } on DioException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.response!.data['message']),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  TextFormField CustomTextField(
      {required String label, required Function(String)? onChanged, FormFieldValidator? validator}) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          hintStyle: const TextStyle(
            fontSize: 16,
          )),
    );
  }
}
