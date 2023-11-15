import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/custom_outlined_button.dart';
import 'package:riasin_app/layout/mua/lihat_semua.dart';
import 'package:riasin_app/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:riasin_app/component/inkwell_animation.dart';

class DetailMua extends StatefulWidget {
  const DetailMua({super.key, required this.idMua});

  @override
  State<DetailMua> createState() => _DetailMuaState();
  final int idMua;
}

class _DetailMuaState extends State<DetailMua> {

  final dio = Dio();
  Map dataMua = {};
  final _storage = const FlutterSecureStorage();
  bool _isLoading = true;

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  Future getDataMua() async {
    try {
      var response = await dio.get('$baseUrl/api/pencari-jasa-mua/detail-mua/${widget.idMua}', options: Options(
        headers: {
          // 'Authorization': 'Bearer ${await _checkToken()}'
          'Authorization': 'Bearer 6|24zDjFbCwtQcshhdHBxiKoTXHdWlnOFX4d8qP6qn530b6331'
        }
      ));
      setState(() {
        dataMua = response.data['data'];
        if(response.statusCode == 200) {
          _isLoading = false;
        }
      });
    } on DioException catch(e) {
      print(e.response);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataMua();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(dataMua['galeri'][0]['foto']),
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
                            Icon(Icons.star, color: Colors.yellow, size: 20,),
                            Text(dataMua['rating'].toString(), style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff848484),
                            ),),
                            const SizedBox(width: 10),
                            Icon(Icons.location_pin,
                                color: Colors.black.withOpacity(0.3), size: 20,),
                            Text("${dataMua['profil']['lokasi_jasa_mua']}, Surabaya", style: TextStyle(
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
                              Text(dataMua['harga'], style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff848484),
                              ),),
                            ]),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text('Tersedia: ', style: TextStyle(
                                    color: Color(0xff848484),
                                  ),),
                                  ...dataMua['kategori'].map<Widget>((e) => ChipKategoriMua(namaJasa: e['nama'],)),
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
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
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
                        style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.7)),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '${dataMua['profil']['lokasi_jasa_mua']}, Surabaya',
                        style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.7)),
                      ),
                      SizedBox(height: 11,),
                      Text(
                        "Harga: ",
                        style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.7)),
                      ),
                      SizedBox(height: 11,),
                      ...dataMua['layanan'].map((e) => Text(
                        '${e['nama']}: ${e['harga']}',
                        style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.7)),
                      )),
                      SizedBox(height: 11,),
                      Text(
                        "Durasi: ",
                        style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.7)),
                      ),
                      SizedBox(height: 11,),
                      ...dataMua['layanan'].map((e) => Text(
                        '${e['nama']}: ${e['durasi']}',
                        style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.7)),
                      )),
                    ],
                  ),
                ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => lihatSemuaReview(data: dataMua['review'],)));
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

                ...dataMua['review'].take(3)
                    .map((e) => ReviewItem(
                        imagePath: e['foto'],
                        serviceName: e['nama_layanan'],
                        serviceLocation: e['nama_kecamatan'],
                        userRating: int.parse(e['rating']),
                        userReview:
                            e['komentar']))
              ],
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
              color: Colors.pink,
              textColor: Colors.white,
              text: 'Pesan Jasa MUA',
              onTap: () {
                // modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      bottomNavigationBar: Row(
                        children: [
                          Expanded(
                            child: InkWellWithAnimation(
                              color: Colors.pink,
                              textColor: Colors.white,
                              text: 'Pesan MUA',
                            ),
                          ),
                          SizedBox()
                        ],
                      ),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Formulir pemesanan',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Harga",
                            ),
                          ],
                        ),
                      ),
                    );
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
    super.key, required this.namaJasa,
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
                color:
                    Color(0xffC55977))),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.imagePath,
    required this.serviceName,
    required this.serviceLocation,
    required this.userRating,
    required this.userReview,
  });

  final String imagePath;
  final String serviceName;
  final String serviceLocation;
  final int userRating;
  final String userReview;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          imagePath,
          width: 35,
          height: 35,
          fit: BoxFit.cover,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.spa,
            color: Color.fromARGB(255, 197, 89, 120),
            size: 12.0,
          ),
          Text(
            serviceName,
            style: TextStyle(
              color: Color.fromARGB(255, 197, 89, 120),
              fontSize: 10,
            ),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.location_on,
            color: Color.fromARGB(255, 197, 89, 120),
            size: 12.0,
          ),
          Text(
            serviceLocation,
            style: TextStyle(
              color: Color.fromARGB(255, 197, 89, 120),
              fontSize: 10,
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              userRating,
              (i) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 12.0,
              ),
            ),
          ),
          Text(
            userReview,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
