import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';
import 'package:riasin_app/layout/detail_review.dart';
import 'package:riasin_app/layout/mua/detail_Pemesanan.dart';

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
                              DetailPemesanan(
                                id: e['id'],
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                                title: Text(
                                    "Review ${e['nama']}")),
                            body: Center(
                              child: CardDetailReview(
                                clientName: e['nama'],
                                bookingDate:
                                DateFormat('dd MMMM yy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(e['tanggal_pemesanan'])).toString(),
                                serviceType: e['nama_kategori'],
                                rating: double.parse(e['rating']).floorToDouble(),
                                // Misalnya, rating 4.5
                                comment:
                                e['komentar'] == null
                                    ? 'Tidak ada komentar'
                                    : e['komentar'],
                                reviewImages: e['foto_review'],
                              ),
                            ),
                          )),
                    );
                  },
                  tanggalPemesanan: DateFormat('dd MMMM yy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(e['tanggal_pemesanan'])).toString(),
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
