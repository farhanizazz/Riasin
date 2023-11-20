import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/pesanan_item_review.dart';
import 'package:riasin_app/layout/client/detail_mua.dart';
import 'package:riasin_app/layout/client/review_pesanan.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final dio = Dio();
  final _storage = const FlutterSecureStorage();
  List data = [];
  final DateFormat formatter = DateFormat('dd MMMM yyyy');

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void getData() async {
    try {
      Response res = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/pemesanan-done',
          options: Options(headers: {
            'Authorization': 'Bearer ${await _storage.read(key: 'token')}'
          }));
      setState(() {
        data = res.data['data'];
      });
    } on DioException catch (e) {
      showSnackbar(e.response!.data['message']);
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
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 33),
          child: Column(
            children: data.map((e) => Column(
              children: [
                PesananItemReview(
                  serviceIcon: 'https://www.presidenri.go.id/assets/uploads/2020/02/presidenri.go.id-05022020111245-5e3a40bd7cdcb1.35250820-384x512.jpg',
                  muaName: e['nama'],
                  serviceName: e['jenis_jasa'],
                  bookingDate: formatter.format(DateTime.parse(data[0]['tanggal_pemesanan'])),
                  isReview: e['review'] != null ? true : false,
                  onGiveReviewTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BeriReviewPesananPage(
                              id: e['id'],
                              namaJasa: e['jenis_jasa'],
                              namaMua: e['nama'],
                              tanggalBook: formatter.format(DateTime.parse(data[0]['tanggal_pemesanan'])),
                            )));
                  },
                ),
                const SizedBox(height: 20),
              ],
            )).toList(),
          )),
    );
  }
}
