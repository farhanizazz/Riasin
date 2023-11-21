import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:riasin_app/layout/mua/detail_review.dart';
// import 'package:riasin_app/mua/detail_review.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/lihat_semua.dart';
import 'package:riasin_app/layout/mua/order_in_client.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required this.dashboardData,
    required this.notifyParent,
  });

  final Map<String, dynamic> dashboardData;
  final Function() notifyParent;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.dashboardData['ulasan']);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xFFC55977),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    widget.dashboardData['profile']['foto'],
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.dashboardData['profile']['nama_jasa_mua'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.dashboardData['profile']['lokasi_jasa_mua'],
                  style: TextStyle(fontSize: 14, color: Color(0xffE1CCD2)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: <Widget>[
        Stack(children: <Widget>[
          Container(
            color: const Color(0xFFC55977),
            height: MediaQuery.of(context).size.height / 12,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Profil Pengguna

                CarouselSlider(
                  items:
                      widget.dashboardData['layananMua'].map<Widget>((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: buildCarouselItem(
                        product['nama'],
                        product['foto'],
                        product['rating'].floor().toDouble(),
                        double.parse(product['harga']),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                    viewportFraction: 1,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0;
                        i < widget.dashboardData['layananMua'].length;
                        i++)
                      Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentCarouselIndex == i
                              ? const Color.fromARGB(255, 197, 89, 120)
                              : Colors.grey,
                        ),
                      ),
                  ],
                ),

                // Daftar Pesanan
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Pesanan Terbaru',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: widget.notifyParent,
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.dashboardData['pesananTerbaru'].take(3).isEmpty
                          ? SizedBox(
                              height: 100,
                              child: const Center(
                                child: Text("Tidak ada pesanan terbaru"),
                              ))
                          : Column(
                              children: [
                                ...widget.dashboardData['pesananTerbaru']
                                    .map((e) => PesananItem(
                                        onTap: () {
                                          Navigator.push(
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
                                          );
                                        },
                                        status: e['status'],
                                        serviceIcon: e['foto'],
                                        clientName: e['nama'],
                                        serviceName: 'Nama Jasa ${e['nama']}',
                                        serviceLocation: 'Sukolilo',
                                        bookingDate:
                                            'Tanggal Booking: ${e['tanggal_pemesanan']}'))
                              ],
                            ),
                    ],
                  ),
                ),

                // ListView untuk review jasa
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Review Terbaru',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => lihatSemuaReview(
                                        data: widget.dashboardData['ulasan']),
                                  ),
                                );
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
                      widget.dashboardData['ulasan'].isEmpty
                          ? SizedBox(
                              height: 100,
                              child: const Center(
                                child: Text("Tidak ada review terbaru"),
                              ))
                          : Column(children: [
                              ...widget.dashboardData['ulasan'].take(3).map(
                                  (e) => ReviewItem(
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
                                                            e['tanggal_pemesanan'],
                                                        serviceType: e['nama_layanan'],
                                                        rating: double.parse(e['rating']).floorToDouble(),
                                                        // Misalnya, rating 4.5
                                                        comment:
                                                            e['komentar'] == null
                                                                ? 'Tidak ada komentar'
                                                                : e['komentar'],
                                                        reviewImages: e['foto_ulasan'],
                                                      ),
                                                    ),
                                                  )),
                                        );
                                      },
                                      imageReview: e['foto_ulasan'],
                                      profilePictureUrl: e['foto'],
                                      serviceName: '${e['nama']}',
                                      userRating: e['rating'] == "" ? 0 : int.parse(e['rating']),
                                      userReview: e['komentar'] == null
                                          ? 'Tidak ada komentar'
                                          : e['komentar']))
                            ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}

Widget buildCarouselItem(
    String name, String imagePath, double rating, double price) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(children: [
          Image.network(
            imagePath,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xffC55977).withOpacity(0.3),
            ),
          ),
        ]),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12.0,
                      ),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Harga: Rp ${price.toStringAsFixed(3)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
