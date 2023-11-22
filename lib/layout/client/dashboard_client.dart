import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/layout/client/lihat_semua.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:riasin_app/layout/client/lihat_semua_review.dart';
import 'package:riasin_app/layout/client/review_pesanan.dart';
import 'package:riasin_app/layout/login_pages/login_page.dart';
import 'package:riasin_app/component/profile_read.dart';

import 'homepage.dart';

class DashboardClient extends StatefulWidget {
  const DashboardClient({super.key, required this.token});

  final String token;

  @override
  _DashboardClientState createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
  String? selectedFilter = 'Semua';
  List<String> filterOptions = ['Semua', 'Paket 1', 'Paket 2', 'Paket 3'];
  int _selectedIndex = 0;
  List<Product> products = [
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
  ];
  final dio = Dio();
  bool isHomeLoading = true;
  bool isProfileLoading = true;
  Map<String, dynamic> dashboardData = {};
  Map<String, dynamic> profileData = {};

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void getDashboard() async {
    try {
      Response<String> res = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/dashboard/',
          options:
              Options(headers: {'Authorization': 'Bearer ${widget.token}'}));
      setState(() {
        if (res.statusCode == 200) {
          dashboardData = jsonDecode(res.data!)['data'];
          isHomeLoading = false;
        }
      });
    } on DioException catch (e) {
      showSnackbar(e.response!.data['message']);
    }
  }

  void getMua() async {
    try {
      Response<String> res = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/layanan-mua',
          options:
          Options(headers: {'Authorization': 'Bearer ${widget.token}'}));
      setState(() {
        if (res.statusCode == 200) {
          dashboardData['mua'] = jsonDecode(res.data!)['data'];
          isHomeLoading = false;
        }
      });
    } on DioException catch (e) {
      showSnackbar(e.response!.data['message']);
    }
  }

  void getProfile() async {
    try {
      Response<String> res = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/autofill-pemesanan',
          options:
              Options(headers: {'Authorization': 'Bearer ${widget.token}'}));
      setState(() {
        if (res.statusCode == 200) {
          profileData = jsonDecode(res.data!)['data'];
          isProfileLoading = false;
        }
      });
    } on DioException catch (e) {
      showSnackbar(e.response!.data['message']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      getDashboard();
      getProfile();
      getMua();
    } on DioException catch (e) {
      print(e.response);
    }
  }

  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(profileData: dashboardData),
      ReviewPage(),
      // HomePage(profileData: profileData),
      isProfileLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProfilePage(
              imagePath: profileData['foto'],
              muaName: profileData['nama'],
              muaPhone: profileData['nomor_telepon'],
              muaBorn: profileData['tanggal_lahir'],
              muaGender:
                  profileData['gender'] == 'L' ? 'Laki-laki' : 'Perempuan',
              onTap: () {
                _storage.delete(key: 'token').then((value) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage())));
              },
            ),
    ];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0xFFC55977),
          )),
      body: isHomeLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
            icon: Icon(Icons.rate_review_rounded),
            label: 'Pesanan',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.grid_on),
          //   label: 'Katalog',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class Product {
  final String imagePath;

  Product(this.imagePath);
}
