import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Url.dart';

class PreviewMUA extends StatefulWidget {
  const PreviewMUA(
      {super.key, required this.previewData, this.getData, this.notifyParent});

  final List previewData;
  final Function()? getData;
  final Function()? notifyParent;

  @override
  State<PreviewMUA> createState() => _PreviewMUAState();
}

class _PreviewMUAState extends State<PreviewMUA> {
  File? selectedPhoto;
  final CancelToken cancelToken = CancelToken();
  final dio = Dio();
  final _storage = const FlutterSecureStorage();

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  Future _pickAndSendImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        selectedPhoto = File(returnedImage.path);
      });

      try {
        final res = await dio
            .post('$baseUrl/api/penyedia-jasa-mua/katalog/createpreviewmua',
            data: FormData.fromMap({
              'foto': base64Encode(selectedPhoto!.readAsBytesSync()),
            }), onSendProgress: (int sent, int total) {
              print("$sent $total");
            },
            cancelToken: cancelToken,
            options: Options(
                headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
        if (res.data['status'] == 'success') {
          widget.notifyParent!();
          final Response newImageRes = await widget.getData!();
          final Map<String, dynamic> newImage =
              jsonDecode(newImageRes.data)['data'].last;
          setState(() {
            widget.previewData.add(newImage);
            selectedPhoto = null;
          });
        }
      } on DioException catch (e) {
        print(e.response);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 17).copyWith(bottom: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Foto-foto preview jasa akan ditampilkan pada client yang mengunjungi profil anda",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff848484),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                padding: const EdgeInsets.all(0),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  ...widget.previewData.map(
                    (e) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            e['foto'] != null
                                ? e['foto']
                                : "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png']",
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: () async {
                              try {
                                Response res = await dio.post(
                                  '$baseUrl/api/penyedia-jasa-mua/katalog/deletepreviewmua/${e['id']}',
                                  options: Options(
                                      headers: {
                                        'Authorization':
                                        'Bearer ${await _checkToken()}'
                                      },
                                      followRedirects: false,
                                      validateStatus: (status) {
                                        return status! < 500;
                                      }),
                                );
                                if(res.data['success'] == true) {
                                  widget.notifyParent!();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Berhasil menghapus foto"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              } on DioException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.response!.data['message']),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              setState(() {
                                widget.previewData.remove(e);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xffC55977),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffE1CCD2),
                    ),
                    child: Center(
                      child: selectedPhoto == null
                          ? Container(
                              color: Color(0xffE1CCD2),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xffC55967)),
                                        shape: MaterialStateProperty.all(
                                            CircleBorder()),
                                      ),
                                      onPressed: () async {
                                        _pickAndSendImage();
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Tambah Foto',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffC55967)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Image.file(
                                  selectedPhoto!,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                                Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cancelToken.cancel();
                                        selectedPhoto = null;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Color(0xffC55977),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
