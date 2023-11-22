import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/custom_outlined_button.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/lihat_semua.dart';
import 'package:riasin_app/layout/mua/galery_pemesanan.dart';
import 'package:riasin_app/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:riasin_app/component/inkwell_animation.dart';

import '../../component/review_item.dart';

class DetailMua extends StatefulWidget {
  const DetailMua({super.key, required this.idMua});

  @override
  State<DetailMua> createState() => _DetailMuaState();
  final int idMua;
}

class _DetailMuaState extends State<DetailMua> {
  int _jumlahPemesan = 0;
  List<String> jasa = ["MakeUp", "Nail Art", "Hijab Do"];
  String _selectedJasa = "";
  final dio = Dio();
  Map dataMua = {};
  Map dataAutofill = {};
  final _storage = const FlutterSecureStorage();
  bool _isLoading = true;
  List<int> unselectableDate = [1, 3, 5];
  String harga = "-";
  DateTime? selectedDate;


  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  void getDataMua() async {
    try {
      var response = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/detail-mua/${widget.idMua}',
          options: Options(headers: {
            'Authorization': 'Bearer ${await _checkToken()}'
            // 'Authorization': 'Bearer 6|24zDjFbCwtQcshhdHBxiKoTXHdWlnOFX4d8qP6qn530b6331'
          }));
      setState(() {
        dataMua = response.data['data'];
        if (response.statusCode == 200) {
          _isLoading = false;
        }
      });
    } on DioException catch (e) {
      print(e.response);
    }
  }

  void getAutofill() async {
    try {
      var response = await dio.get(
          '$baseUrl/api/penyedia-jasa-mua/dashboard/profile',
          options: Options(headers: {
            'Authorization': 'Bearer ${await _checkToken()}'
            // 'Authorization': 'Bearer 6|24zDjFbCwtQcshhdHBxiKoTXHdWlnOFX4d8qP6qn530b6331'
          }));
      setState(() {
        dataAutofill = response.data['data'];
        if (response.statusCode == 200) {
          _isLoading = false;
        }
      });
    } on DioException catch (e) {
      print(e.response);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataMua();
    getAutofill();
  }

  @override
  Widget build(BuildContext context) {
    print(dataMua['galeri']);
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(dataMua['galeri'][0]['foto'][0]),
                      Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(dataMua['profil']['nama_jasa_mua']),
                                  //     CustomOutlinedButton()
                                  //         .setLabel("Lihat Portofolio Saya")
                                  //         .setFontSize(10)
                                  //         .setOnPressed(() async {
                                  //       if (!await launchUrl(Uri.parse(dataMua['portofolio'][0]['file']))) {
                                  //         throw Exception('Could not launch portofolio');
                                  //       }
                                  //     })
                                  //         .build(context),
                                  //   ],
                                  // ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                      Text(
                                        dataMua['rating'].toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff848484),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.black.withOpacity(0.3),
                                        size: 20,
                                      ),
                                      Text(
                                          "${dataMua['profil']['lokasi_jasa_mua']}, Surabaya",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff848484),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.attach_money_rounded,
                                          color: Colors.black.withOpacity(0.3),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          dataMua['harga'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff848484),
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          spacing: 10,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              'Tersedia: ',
                                              style: TextStyle(
                                                color: Color(0xff848484),
                                              ),
                                            ),
                                            ...dataMua['layanan']
                                                .map<Widget>((e) => ChipKategoriMua(
                                                      namaJasa: e['nama'],
                                                    )),
                                            // ChipKategoriMua(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        child: Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Deskripsi',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Lokasi: ",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  '${dataMua['profil']['lokasi_jasa_mua']}, Surabaya',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Text(
                                  "Harga: ",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                ...dataMua['layanan'].map((e) => Text(
                                      '${e['nama']}: ${e['harga']}',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black.withOpacity(0.7)),
                                    )),
                                SizedBox(
                                  height: 11,
                                ),
                                Text(
                                  "Durasi: ",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                ...dataMua['layanan'].map((e) => Text(
                                      '${e['nama']}: ${e['durasi']}',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black.withOpacity(0.7)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Galeri Client',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: 270),
                        child: GridView.builder(
                          itemCount: dataMua['galeri'].length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.0),
                              child: SizedBox(child: CardGallery(title: dataMua['galeri'][index]['deskripsi'], imageUrls: dataMua['galeri'][index]['foto'] is List ? dataMua['galeri'][index]['foto'].take(4).toList() : [dataMua['galeri'][index]['foto']],)),
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1),
                        ),
                      ),

                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Review Terbaru',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => lihatSemuaReview(
                                                  data: dataMua['review'],
                                                )));
                                  },
                                  child: Text(
                                    'Lihat Semua',
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ListView untuk daftar review

                          dataMua['review'].isEmpty
                              ? SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text("Belum ada review"),
                                  ),
                                )
                              : Column(
                                  children: dataMua['review']
                                      .take(3)
                                      .map<Widget>((e) => ReviewItem(
                                          profilePictureUrl: e['foto'],
                                          tanggalPemesanan: e['tanggal_pemesanan'],
                                          serviceName: e['nama_kategori'],
                                          userRating: int.parse(e['rating']),
                                          userReview: e['komentar']))
                                      .toList(),
                                ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(top: 30, left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: InkWellWithAnimation(
              color: Colors.white,
              textColor: Colors.pink,
              text: 'Hubungi MUA',
            ),
          ),
          Expanded(
            child: InkWellWithAnimation(
              color: Color(0xffC55977),
              textColor: Colors.white,
              text: 'Pesan Jasa MUA',
              onTap: () {
                // modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Scaffold(
                          bottomNavigationBar: Row(
                            children: [
                              Expanded(
                                child: InkWellWithAnimation(
                                  onTap: () {},
                                  color: Color(0xffC55977),
                                  textColor: Colors.white,
                                  text: 'Pesan MUA',
                                ),
                              ),
                            ],
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Harga",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      harga,
                                      style: TextStyle(
                                        color: Color(0xffC55977),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                                const Divider(
                                  color: Color(0xffE1CCD2),
                                ),
                                const SizedBox(height: 12.0),
                                Text(
                                  "Pesan Jasa",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Wrap(
                                              spacing: 8.0,
                                              runSpacing: 4.0,
                                              children: dataMua['layanan'].map<Widget>((e) => ChoiceChip(
                                                showCheckmark: false,
                                                selectedColor:
                                                Color(0xffC55977),
                                                side: BorderSide(
                                                    color: Color(0xffC55977),
                                                    width: 1.2),
                                                label: Text(
                                                  e['nama'],
                                                  style: TextStyle(
                                                    color: _selectedJasa ==
                                                        e['nama']
                                                        ? Colors.white
                                                        : Color(0xffC55977),
                                                    fontWeight:
                                                    FontWeight.bold,
                                                  ),
                                                ),
                                                selected: _selectedJasa ==
                                                    e['nama'],
                                                onSelected: (bool selected) {
                                                  setState(() {
                                                    _selectedJasa = selected
                                                        ? e['nama']
                                                        : "";
                                                    harga = e['harga'];
                                                  });
                                                },
                                              )).toList(),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                const Divider(
                                  color: Color(0xffE1CCD2),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Banyak Orang",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                              color: Color(0xffC55977),
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              minimumSize: const Size(0, 0),
                                              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Color(0xffC55977),
                                                      width: 1.2),
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          onPressed: () {
                                            if (_jumlahPemesan <= 0) {
                                              setState(() {
                                                _jumlahPemesan = 0;
                                              });
                                            } else {
                                              setState(() {
                                                _jumlahPemesan--;
                                              });
                                            }
                                          },
                                        ),
                                        Text(
                                          _jumlahPemesan.toString(),
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xffC55977),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          child: Text("+"),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              minimumSize: Size(0, 0),
                                              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          onPressed: () {
                                            setState(() {
                                              _jumlahPemesan++;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Color(0xffE1CCD2),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tanggal Booking",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      icon: const Icon(
                                          Icons.calendar_month_rounded),
                                      onPressed: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 365)),
                                        ).then((value) {
                                          setState(() {
                                            selectedDate = value;
                                          });
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Text(
                                  selectedDate == null
                                      ? "Pilih tanggal booking"
                                      : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                                  style: TextStyle(
                                    color: Color(0xffC55977),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChipKategoriMua extends StatelessWidget {
  const ChipKategoriMua({
    super.key,
    required this.namaJasa,
  });

  final String namaJasa;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ActionChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: const Color(0xffE1CCD2),
        side: const BorderSide(color: Colors.transparent),
        onPressed: () {
          print('pressed!');
        },
        label: Text(namaJasa,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffC55977))),
      ),
    );
  }
}
