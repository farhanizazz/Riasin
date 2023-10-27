import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';

class lihatSemuaPesanan extends StatelessWidget {
  const lihatSemuaPesanan({super.key, this.data = const []});

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
                      (e) => const SizedBox(
                          width: double.infinity,
                          child: PesananItem(
                            bookingDate: "Test",
                            clientName: "Test",
                            serviceIcon: "Test",
                            serviceLocation: "Test",
                            serviceName: "Test",
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
                            serviceLocation: "Sukolilo",
                            imagePath: "s",
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
