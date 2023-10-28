import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/layout/client/lihat_semua.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:riasin_app/layout/login_pages/login_page.dart';

import 'homepage.dart';

class DashboardClient extends StatefulWidget {
  const DashboardClient({super.key, required this.token});

  final String token;

  @override
  _DashboardClientState createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
  List<String> chipLabels = [
    'Semua',
    'Make Up',
    'Hair Do',
    'Hijab Do',
    'Nail Art'
  ];
  String? selectedFilter = 'Semua';
  List<String> filterOptions = ['Semua', 'Paket 1', 'Paket 2', 'Paket 3'];
  int _selectedIndex = 0;
  List<Product> products = [
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
  ];
  final dio = Dio();
  bool isLoading = true;
  Map<String, dynamic> profileData = {};

  void getDashboard() async {
    try {
      Response<String> profileData = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/dashboard/',
          options:
              Options(headers: {'Authorization': 'Bearer ${widget.token}'}));
      setState(() {
        if (profileData.statusCode == 200) {
          this.profileData = jsonDecode(profileData.data!)['data'];
          print(this.profileData);
          isLoading = false;
        }
      });
    } on DioException catch (e) {
      print(e.response);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      getDashboard();
    } on DioException catch (e) {
      print(e.response);
    }
  }

  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(profileData: profileData),
      // HomePage(profileData: profileData),
      // HomePage(profileData: profileData),
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

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0xFFC55977),
          )),
      body: isLoading
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.spa),
          //   label: 'Pesanan',
          // ),
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
