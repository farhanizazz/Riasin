import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';
import 'package:riasin_app/layout/mua/order_in_client.dart';

class LihatSemuaPesanan extends StatelessWidget {
  const LihatSemuaPesanan({super.key, required this.data});

  final List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: !Navigator.canPop(context) ? null : Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Lihat Semua",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
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
                              onTap: () {
                                e['status'] == "pending" ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderInClient(
                                          id: e['id'],
                                          nama: 'Farhan Iz',
                                          nomor: '0812',
                                          gender: 'Laki-Laki',
                                          request:
                                          'Request Tambahan untuk MUA',
                                        ),
                                  ),
                                ) : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Pesanan sudah ${e['status'] == "accept" ? "diterima" : e['status'] == "decline" ? "ditolak" : "selesai"}'),
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
