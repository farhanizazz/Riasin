import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';
import 'package:riasin_app/layout/detail_review.dart';
import 'package:riasin_app/layout/mua/detail_Pemesanan.dart';

class LihatSemuaPesanan extends StatefulWidget {
  const LihatSemuaPesanan({super.key, required this.data});

  final List data;

  @override
  State<LihatSemuaPesanan> createState() => _LihatSemuaPesananState();
}

class _LihatSemuaPesananState extends State<LihatSemuaPesanan> {
  final dio = Dio();

  List data = [];

  final _storage = const FlutterSecureStorage();
  DateFormat dateFormatter = DateFormat('dd MMMM yyyy');

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? Center(
              child: Text("Tidak ada pesanan terbaru"),
            )
          : RefreshIndicator(
              onRefresh: () async {
                try {
                  Response res = await dio.get(
                      '$baseUrl/api/penyedia-jasa-mua/dashboard/seluruhpesanan',
                      options: Options(headers: {
                        'Authorization': 'Bearer ${await _checkToken()}'
                      }));
                  setState(() {
                    data = res.data['data'];
                  });
                } on DioException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.response!.data.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                  print(e.response!.data);
                }
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: data
                        .map(
                          (e) => SizedBox(
                              width: double.infinity,
                              child: PesananItem(
                                  onTap: () async {
                                    e['status'] == "pending"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPemesanan(
                                                id: e['id'],
                                              ),
                                            ),
                                          ).then((value) async {
                                            try {
                                              Response res = await dio.get(
                                                  '$baseUrl/api/penyedia-jasa-mua/dashboard/seluruhpesanan',
                                                  options: Options(headers: {
                                                    'Authorization':
                                                        'Bearer ${await _checkToken()}'
                                                  }));
                                              setState(() {
                                                data = res.data['data'];
                                              });
                                            } on DioException catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(e.response!.data
                                                      .toString()),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              print(e.response!.data);
                                            }
                                          })
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Pesanan sudah ${e['status'] == "accept" ? "diterima" : e['status'] == "decline" ? "ditolak" : "selesai"}'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                  },
                                  status: e['status'],
                                  serviceIcon: e['foto'],
                                  clientName: '${e['nama']}',
                                  serviceName: '${e['nama']}',
                                  serviceLocation: 'Sukolilo',
                                  bookingDate:
                                      'Tanggal Booking: ${dateFormatter.format(DateFormat('dd-MM-yyyy').parse(e['tanggal_pemesanan'])).toString()}')),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
    );
  }
}

class lihatSemuaReview extends StatelessWidget {
  const lihatSemuaReview({super.key, this.data = const []});

  final List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Lihat Semua",
        ),
      ),
      body: data.isEmpty
          ? Center(
              child: Text("Tidak ada review terbaru"),
            )
          : SingleChildScrollView(
              child: Column(
                children: data
                    .map(
                      (e) => SizedBox(
                          width: double.infinity,
                          child: ReviewItem(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                              title:
                                                  Text("Review ${e['nama']}")),
                                          body: Center(
                                            child: CardDetailReview(
                                              clientName: e['nama'],
                                              bookingDate:
                                                  e['tanggal_pemesanan'],
                                              serviceType: e['nama_layanan'],
                                              rating: double.parse(e['rating'])
                                                  .floorToDouble(),
                                              // Misalnya, rating 4.5
                                              comment: e['komentar'] == null
                                                  ? 'Tidak ada komentar'
                                                  : e['komentar'],
                                              reviewImages: e['foto_ulasan'],
                                            ),
                                          ),
                                        )),
                              );
                            },
                            tanggalPemesanan: e['tanggal_pemesanan'],
                            serviceName: e['nama'],
                            profilePictureUrl: e['foto'],
                            userRating: int.parse(e['rating']),
                            userReview: e['komentar'],
                            imageReview: e['foto_ulasan'],
                          )),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
