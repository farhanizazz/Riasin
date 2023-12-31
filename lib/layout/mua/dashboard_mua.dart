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
import 'package:riasin_app/layout/register_pages/mua/register_page_data_diri.dart';

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
  late Map<String, dynamic> dashboardData = {
    'profile': {},
    'layananMua': {},
    'ulasan': {},
    'pesananTerbaru': {},
    'pesanan': {}
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

  Future<Response<String>> getPesanan() async {
    Response<String> data = await dio.get(
        '$baseUrl/api/penyedia-jasa-mua/dashboard/seluruhpesanan',
        options: Options(
            headers: {'Authorization': 'Bearer ${await _checkToken()}'}));
    return data;
  }


  void getData() async {
    try {
      List<Response<String>> data = await Future.wait(
          [getProfile(), getLayananMua(), getUlasan(), getPesananTerbaru(), getPesanan()]);

      setState(() {
        dashboardData = {
          'profile': jsonDecode(data[0].data!)['data'],
          'layananMua': jsonDecode(data[1].data!)['data'],
          'ulasan': jsonDecode(data[2].data!)['data'],
          'pesananTerbaru': jsonDecode(data[3].data!)['data'],
          'pesanan': jsonDecode(data[4].data!)['data']
        };
        _loading = false;
        pages = [
          Homepage(
            dashboardData: dashboardData,
            refreshParent: () {
              setState(() {
                _loading = true;
              });
              getData();
            },
            notifyParent: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          LihatSemuaPesanan(
            data: dashboardData['pesanan'],
          ),
          KatalogPage(),
          ProfilePage(
            imagePath:
            dashboardData['profile']['foto'] ?? 'assets/images/mua.jpg',
            muaName: dashboardData['profile']['nama'] ?? 'Nama MUA',
            muaPhone: dashboardData['profile']['nomor_telepon'] ?? 'Tidak ada Nomor Telepon',
            muaBorn: dashboardData['profile']['tanggal_lahir'] ?? 'Tidak ada Tanggal Lahir',
            muaGender: dashboardData['profile']['jenis_kelamin'] == 'L'
                ? 'Laki-laki'
                : 'Perempuan',
          ),
        ];
      });
    } on DioException catch (e) {
      if(e.response!.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silahkan lengkapi data diri anda!'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red[800],
          ),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const RegisterPageDataDiri()));
      }
    }
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
