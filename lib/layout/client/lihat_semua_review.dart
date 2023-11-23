import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/pesanan_item_review.dart';
import 'package:riasin_app/layout/client/detail_mua.dart';
import 'package:riasin_app/layout/client/review_pesanan.dart';
import 'package:riasin_app/layout/detail_review.dart';

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
  bool _loading = true;

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
        _loading = false;
      });
    } on DioException catch (e) {
      showSnackbar(e.response!.data.toString());
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
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data.isEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    getData();
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text("Tidak ada review"),
                      ),
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    getData();
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 33),
                        child: Column(
                          children: data
                              .map((e) => Column(
                                    children: [
                                      PesananItemReview(
                                        onLihatReviewTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                        appBar: AppBar(
                                                          title: Text(
                                                              'Detail Review',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        body: CardDetailReview(
                                                          id: e['id'],
                                                          clientName: e['nama'],
                                                          bookingDate: formatter
                                                              .format(DateTime
                                                                  .parse(e[
                                                                      'tanggal_pemesanan'])),
                                                          serviceType:
                                                              e['jenis_jasa'],
                                                          rating: e['review'][
                                                                      'rating'] !=
                                                                  null
                                                              ? double.parse(e[
                                                                          'review']
                                                                      ['rating']
                                                                  .toString())
                                                              : 0,
                                                          comment: e['review'][
                                                                      'komentar'] !=
                                                                  null
                                                              ? e['review']
                                                                  ['komentar']
                                                              : '',
                                                          reviewImages:
                                                              e['foto_review'] !=
                                                                      null
                                                                  ? e['foto_review']
                                                                  : [],
                                                        ),
                                                      )));
                                        },
                                        serviceIcon: e['foto'],
                                        muaName: e['nama'],
                                        serviceName: e['jenis_jasa'],
                                        bookingDate: formatter.format(
                                            DateTime.parse(
                                                e['tanggal_pemesanan'])),
                                        isReview:
                                            e['review'] != null ? true : false,
                                        onGiveReviewTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BeriReviewPesananPage(
                                                        id: e['id'],
                                                        namaJasa:
                                                            e['jenis_jasa'],
                                                        namaMua: e['nama'],
                                                        tanggalBook: formatter
                                                            .format(DateTime
                                                                .parse(data[0][
                                                                    'tanggal_pemesanan'])),
                                                      ))).then(
                                              (value) => getData());
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ))
                              .toList(),
                        )),
                  ),
                ),
    );
  }
}
