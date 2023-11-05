import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';

class LihatSemuaPesanan extends StatelessWidget {
  const LihatSemuaPesanan({super.key, this.data = const []});

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
              child: Text("Tidak ada pesanan terbaru"),
            )
          : SingleChildScrollView(
              child: Column(
                children: data
                    .map(
                      (e) => SizedBox(
                          width: double.infinity,
                          child: PesananItem(
                              serviceIcon: e['foto'],
                              clientName: '${e['nama']}',
                              serviceName: '${e['nama']}',
                              serviceLocation: 'Sukolilo}',
                              bookingDate:
                              'Tanggal Booking: ${e['tanggal_pemesanan']}'
                          )),
                    )
                    .toList(),
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
              child: Text("Tidak ada pesanan terbaru"),
            )
          : SingleChildScrollView(
              child: Column(
                children: data
                    .map(
                      (e) => SizedBox(
                          width: double.infinity,
                          child: ReviewItem(
                            serviceName: e['nama_pencari'],
                            imagePath: e['foto'],
                            userRating: int.parse(e['rating']),
                            userReview: e['komentar'],
                          )),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
