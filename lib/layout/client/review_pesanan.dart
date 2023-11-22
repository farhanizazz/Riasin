import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/inkwell_animation.dart';
import 'package:riasin_app/component/upload_with_label.dart';
// import 'package:riasin_app/main.dart';

class BeriReviewPesananPage extends StatefulWidget {
  final String namaJasa;
  final String namaMua;
  final String tanggalBook;
  final int id;

  const BeriReviewPesananPage({super.key,
    required this.namaJasa,
    required this.namaMua,
    required this.tanggalBook, required this.id});

  @override
  _BeriReviewPesananPageState createState() => _BeriReviewPesananPageState();
}

class _BeriReviewPesananPageState extends State<BeriReviewPesananPage> {
  int rating = 0;
  String komentar = '';
  List<File> files = [];
  final dio = Dio();
  final _storage = FlutterSecureStorage();
  bool _isLoading = false;

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  void showSnackbar(String msg, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Beri Review', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              'Jasa MUA',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 197, 89, 120)),
                                            ),
                                            Text(
                                              widget.namaMua,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Jenis Jasa',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 197, 89, 120)),
                                            ),
                                            Text(
                                              widget.namaJasa,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Tanggal Booking',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 197, 89, 120)),
                                            ),
                                            Text(
                                              widget.tanggalBook,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        )),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              'Jasa MUA',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 197, 89, 120)),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: List.generate(
                                                  5, (index) {
                                                final isFilled = index < rating;

                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rating = index + 1;
                                                    });
                                                  },
                                                  child: Icon(
                                                    isFilled
                                                        ? Icons.star_rounded
                                                        : Icons
                                                        .star_border_rounded,
                                                    color: Colors.amber,
                                                    size: 30,
                                                    // Ukuran bintang
                                                    semanticLabel: 'Rating $rating of 5',
                                                    key: Key('rating_$rating'),
                                                  ),
                                                );
                                              }),
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(
                                              height: 150,
                                              child: TextFormField(
                                                textAlignVertical: TextAlignVertical
                                                    .top,
                                                expands: true,
                                                keyboardType: TextInputType
                                                    .multiline,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  hintText: 'Komentar atau Ulasan',
                                                  hintStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey,
                                                  ),
                                                  contentPadding: EdgeInsets
                                                      .all(10),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide: BorderSide(
                                                      color: Color(0xffDFC0C9),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                    borderSide: BorderSide(
                                                      color: Color(0xffDFC0C9),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    komentar = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(
                                                  'Foto Testimoni Jasa',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                    Color.fromARGB(
                                                        255, 197, 89, 120),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  '(Maks 5 foto)',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w100,
                                                    color:
                                                    Color.fromARGB(
                                                        255, 197, 89, 120),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            files.isNotEmpty
                                                ? Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 100,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                      Axis.horizontal,
                                                      itemCount: files.length,
                                                      itemBuilder: (context,
                                                          index) {
                                                        return Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              right: 10),
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                            image: DecorationImage(
                                                              image: FileImage(
                                                                  files[index]),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                            Alignment.topRight,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  files
                                                                      .removeAt(
                                                                      index);
                                                                });
                                                              },
                                                              child: Container(
                                                                margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                                width: 20,
                                                                height: 20,
                                                                decoration:
                                                                BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      10),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : UploadWithLabel(
                                              onTap: pickImage,
                                              icon: Icon(
                                                Icons.image,
                                                color: Color(0xffC55977),
                                                size: 40.0,
                                              ),
                                              hint: "Upload Foto",
                                            ),
                                          ],
                                        )),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          )),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: InkWellWithAnimation(
              onTap: _isLoading ? null : () async {
                if (rating == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Rating harus diisi'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red[800],
                    ),
                  );
                } else if (komentar.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Komentar harus diisi'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red[800],
                    ),
                  );
                } else if (files.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Foto harus diisi'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red[800],
                    ),
                  );
                } else {
                  try {
                    setState(() {
                      _isLoading = true;
                    });
                    Response res = await dio.post("$baseUrl/api/pencari-jasa-mua/create-review",
                        options: Options(headers: {
                          'Authorization': 'Bearer ${await _checkToken()}'
                        }),data: FormData.fromMap({
                          'pemesanan_id': widget.id,
                          'rating': rating,
                          'ulasan': komentar,
                          'gambar[]': files.map((e) => base64Encode(e.readAsBytesSync())).toList(),
                        }));
                    if (res.data['status'] == 'success') {
                      showSnackbar("Berhasil memberi review", Colors.green[800]);
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.pop(context);
                    } else {
                      showSnackbar(res.data['message'].toString(), Colors.red[800]);
                      setState(() {
                        _isLoading = false;
                      });
                      print(res.data.toString());
                      print(res.statusCode.toString());
                    }
                  } on DioException catch (e) {
                    setState(() {
                      _isLoading = false;
                    });
                    showSnackbar(e.response!.data['message'], Colors.red[800]);
                  }
                }
              },
              color: _isLoading ? Color.fromARGB(110, 190, 97, 128) : Color.fromARGB(255, 197, 89, 120),
              textColor: Colors.white,
              text: 'Beri Review',
            ),
          ),
        ],
      ),
    );
  }
}
