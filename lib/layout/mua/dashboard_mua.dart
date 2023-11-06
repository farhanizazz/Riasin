import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/pesanan_item.dart';
import 'package:riasin_app/component/review_item.dart';
import 'package:riasin_app/layout/login_pages/login_page.dart';
import 'package:riasin_app/layout/mua/lihat_semua.dart';
import 'package:riasin_app/layout/mua/order_in_client.dart';

class DashboardMua extends StatefulWidget {
  @override
  _DashboardMuaState createState() => _DashboardMuaState();
}

class _DashboardMuaState extends State<DashboardMua> {
  final dio = Dio();
  final _storage = const FlutterSecureStorage();
  bool _loading = true;

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  int _selectedIndex = 0;
  int _currentCarouselIndex = 0;
  List<CarouselItem> products = [
    CarouselItem('Nama Produk 1', 'assets/images/mua.jpg', 4.5, 50.0),
    CarouselItem('Nama Produk 2', 'assets/images/mua.jpg', 4.0, 40.0),
    CarouselItem('Nama Produk 3', 'assets/images/mua.jpg', 4.2, 45.0),
  ];
  late Map<String, dynamic> dashboardData = {
    'profile': {},
    'layananMua': {},
    'ulasan': {},
    'pesananTerbaru': {}
  };

  Future<Response<String>> getProfile() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/dashboard/profile',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }

  Future<Response<String>> getLayananMua() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/dashboard/layananmua',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }

  Future<Response<String>> getUlasan() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/dashboard/ulasan',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }

  Future<Response<String>> getPesananTerbaru() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/dashboard/pesananterbaru',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }


  void getData() async {
    List<Response<String>> data = await Future.wait(
        [getProfile(), getLayananMua(), getUlasan(), getPesananTerbaru()]);

    setState(() {
      dashboardData = {
        'profile': jsonDecode(data[0].data!)['data'],
        'layananMua': jsonDecode(data[1].data!)['data'],
        'ulasan': jsonDecode(data[2].data!)['data'],
        'pesananTerbaru': jsonDecode(data[3].data!)['data']
      };
      _loading = false;
      pages = [
        Homepage(dashboardData: dashboardData),
        Center(
          child: ElevatedButton(
            child: Text('Logout'),
            onPressed: () {
              _storage.delete(key: 'token').then((value) =>
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage())));
            },
          ),
        )
      ];
    });
  }

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    try {
      getData();
    } on DioException catch (e) {
      log(e.response!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _loading
          ? null
          : AppBar(
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
                          dashboardData['profile']['foto'],
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
                        dashboardData['profile']['nama_jasa_mua'],
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
                        dashboardData['profile']['lokasi_jasa_mua'],
                        style:
                            TextStyle(fontSize: 14, color: Color(0xffE1CCD2)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: _loading
          ? Center(child: const CircularProgressIndicator())
          : pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Aksi saat salah satu tombol navigasi ditekan
        },
        selectedItemColor: const Color(0xffC55977),
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(Icons.spa),
          //   label: 'Pesanan',
          // ),
          // const BottomNavigationBarItem(
          //   icon: Icon(Icons.grid_on),
          //   label: 'Katalog',
          // ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
// Widget _buildCarouselItem(String imagePath) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(16.0),
//     child: Image.asset(
//       imagePath,
//       width: double.infinity,
//       fit: BoxFit.cover,
//     ),
//   );
// }
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

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
    required this.dashboardData,
  });

  final Map<String, dynamic> dashboardData;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
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
                        margin:
                            const EdgeInsets.symmetric(horizontal: 2.0),
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Pesanan Terbaru',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LihatSemuaPesanan(
                                      data:
                                          widget.dashboardData['pesananTerbaru'],
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.dashboardData['pesananTerbaru'].isEmpty
                          ? SizedBox(
                              height: 100,
                              child: const Center(
                                child: Text("Tidak ada pesanan terbaru"),
                              ))
                          : Column(
                              children: [
                                ...widget.dashboardData['pesananTerbaru']
                                    .take(3)
                                    .map((e) => PesananItem(
                                        serviceIcon: e['foto'],
                                        clientName: e['nama'],
                                        serviceName: 'Nama Jasa ${e['nama']}',
                                        serviceLocation: 'Sukolilo}',
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
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Review Terbaru',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        lihatSemuaReview(
                                            data:
                                                widget.dashboardData['ulasan']),
                                  ),
                                );
                              },
                              child: Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
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
                                      imagePath: e['foto'],
                                      serviceName: '${e['nama_pencari']}',
                                      userRating: int.parse(e['rating']),
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
      ]);
  }
}

class CarouselItem {
  final String name;
  final String imagePath;
  final double rating;
  final double price;

  CarouselItem(this.name, this.imagePath, this.rating, this.price);
}
