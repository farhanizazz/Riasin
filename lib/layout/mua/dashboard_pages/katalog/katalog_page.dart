import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/katalog/add_katalog_jasa.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/katalog/preview_mua.dart';

import 'edit_katalog_jasa.dart';

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  bool _isPreviewMUALoading = true;
  bool _isKatalogJasaLoading = true;
  final dio = Dio();
  final _storage = const FlutterSecureStorage();
  List previewMUAData = [];
  List katalogJasaData = [];
  File? selectedPhoto;
  CancelToken cancelToken = CancelToken();

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  Future<Response<String>> getPreviewMUA() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/katalog/previewmua',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }

  Future<Response<String>> getKatalogJasa() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/katalog/katalogjasa',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }

  void getData() {
    print("test");
    try {
      getPreviewMUA().then((value) {
        setState(() {
          _isPreviewMUALoading = false;
          previewMUAData = jsonDecode(value.data!)['data'];
        });
      });
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.response!.data['message']),
        backgroundColor: Colors.red,
      ));
    }

    try {
      getKatalogJasa().then((value) {
        setState(() {
          _isKatalogJasaLoading = false;
          katalogJasaData = jsonDecode(value.data!)['data'];
          print(katalogJasaData);
        });
      });
    } on DioException catch (e) {
      print(e);
    }
  }

  Future _pickAndSendImage() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null) return;
    setState(() {
      selectedPhoto = File(returnedImage.path);
    });

    try {
      final res = await dio.post('$baseUrl/api/penyedia-jasa-mua/katalog/createpreviewmua',
          data: FormData.fromMap({
            'foto': base64Encode(selectedPhoto!.readAsBytesSync()),
          }),
          onSendProgress: (int sent, int total) {
            print("$sent $total");
          },
          cancelToken: cancelToken,
          options: Options(
              headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
      if(res.data['status'] == 'success') {
        getData();
        selectedPhoto = null;
      }
    } on DioException catch (e) {
      print(e.response);
    }

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
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 37),
      child: RefreshIndicator(
        onRefresh: () async {
          _isKatalogJasaLoading = true;
          _isPreviewMUALoading = true;
          getData();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Preview MUA",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewMUA(previewData: previewMUAData, getData: getPreviewMUA, notifyParent: getData,)));
                    },
                    child: const Text(
                      "Lihat Semua",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ))
              ],
            ),
            _isPreviewMUALoading
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                      child: CircularProgressIndicator(),
                    ),
                )
                : GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(0),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    children: [
                      selectedPhoto == null ? Container(
                        color: Color(0xffE1CCD2),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xffC55967)),
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
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
                                    fontSize: 10, color: Color(0xffC55967)),
                              )
                            ],
                          ),
                        ),
                      ) : Stack(
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
                      ...previewMUAData.take(5).map(
                            (e) => Stack(
                              children: [
                                Image.network(
                                  e['foto'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          )
                    ],
                  ),
            const SizedBox(
              height: 34,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Katalog Jasa",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 15),
            KatalogJasaItem(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const KatalogJasa()));
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffDFC0C9),
                border: Border.all(color: Color(0xffC55967), width: 1),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xffC55967)),
                        shape: MaterialStateProperty.all(CircleBorder()),
                      ),
                    ),
                    Text(
                      'Tambah Jasa',
                      style: TextStyle(fontSize: 10, color: Color(0xffC55967)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            _isKatalogJasaLoading ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(child: CircularProgressIndicator(),),
            ) : Column(
                children: katalogJasaData
                    .map((e) => Column(
                          children: [
                            Hero(
                              tag: "katalogJasa${e['id']}",
                              child: KatalogJasaItem(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditKatalogJasa(
                                                id: e['id'],
                                                photoUrl: e['foto'],
                                                nama: e['nama'],
                                              )));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        e['foto'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            e['nama'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ))
                    .toList())
          ],
        ),
      ),
    ));
  }
}

class KatalogJasaItem extends StatelessWidget {
  const KatalogJasaItem({
    this.decoration,
    super.key,
    this.child,
    this.onTap,
    this.height = 85,
  });

  final Decoration? decoration;
  final Widget? child;
  final Function()? onTap;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
            decoration: decoration,
            width: double.infinity,
            height: height.toDouble(),
            child: child),
      ),
    );
  }
}
