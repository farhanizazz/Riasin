import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/profile_read.dart';
import 'package:riasin_app/icons/spa_icon.dart';
import 'package:riasin_app/layout/login_pages/login_page.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/homepage.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/katalog/katalog_page.dart';
import 'package:riasin_app/layout/mua/dashboard_pages/lihat_semua.dart';

class DashboardMua extends StatefulWidget {
  @override
  _DashboardMuaState createState() => _DashboardMuaState();
}

class _DashboardMuaState extends State<DashboardMua> {
  final dio = Dio();
  bool _loading = true;
  final _storage = const FlutterSecureStorage();

  Future<String?> _checkToken() async {
    return await _storage.read(key: 'token');
  }

  int _selectedIndex = 0;
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
        Homepage(
          dashboardData: dashboardData,
          notifyParent: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        LihatSemuaPesanan(
          data: dashboardData['pesananTerbaru'],
        ),
        KatalogPage(),
        ProfileRead(
          imagePath:
              'https://upload.wikimedia.org/wikipedia/commons/b/be/Joko_Widodo_2019_official_portrait.jpg',
          muaName: 'Farhan Iz',
          muaPhone: '0812345',
          muaBorn: '17 Agustus 1945',
          muaGender: 'Laki-Laki',
          onTap: () {
            _storage.delete(key: 'token').then((value) =>
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage())));
          },
        ),
        // Center(
        //   child: ElevatedButton(
        //     child: Text('Logout'),
        //     onPressed: () {
        //       _storage.delete(key: 'token').then((value) =>
        //           Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => const LoginPage())));
        //     },
        //   ),
        // )
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(SpaIcon.vector),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
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

class CarouselItem {
  final String name;
  final String imagePath;
  final double rating;
  final double price;

  CarouselItem(this.name, this.imagePath, this.rating, this.price);
}
