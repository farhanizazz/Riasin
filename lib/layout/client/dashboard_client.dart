import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  int _currentCarouselIndex = 0;
  List<Product> products = [
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
  ];
  final dio = Dio();
  bool isLoading = true;
  late Map<String, dynamic> profileData;

  void getDashboard() async {
    try {
      Response<String> profileData = await dio.get('$baseUrl/api/pencari-jasa-mua/dashboard/3',
          options: Options(headers: {'Authorization': 'Bearer ${widget.token}'}));
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
    getDashboard();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  color: const Color(0xFFC55977),
                  height: MediaQuery.of(context).size.height / 3,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Profil Pengguna
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  'assets/images/profile.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Hi,',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                                Text(
                                  profileData['client']['nama'],
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Kolom Pencarian dan Filter
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: "Cari Jasa MUA",
                                    hintStyle: TextStyle(fontSize: 12),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10.0),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    // Tindakan yang diambil saat salah satu item dropdown dipilih
                                    if (value == "filter1") {
                                      // Aksi untuk Filter 1
                                    } else if (value == "filter2") {
                                      // Aksi untuk Filter 2
                                    } else if (value == "filter3") {
                                      // Aksi untuk Filter 3
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: "filter1",
                                        child: const Text("Filter 1"),
                                        onTap: () {
                                          // Aksi untuk Filter 1
                                        },
                                      ),
                                      PopupMenuItem<String>(
                                        value: "filter2",
                                        child: const Text("Filter 2"),
                                        onTap: () {
                                          // Aksi untuk Filter 2
                                        },
                                      ),
                                      PopupMenuItem<String>(
                                        value: "filter3",
                                        child: const Text("Filter 3"),
                                        onTap: () {
                                          // Aksi untuk Filter 3
                                        },
                                      ),
                                    ];
                                  },
                                  child: const Icon(Icons.filter_list,
                                      color: Colors.white), // Warna pink
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      CarouselSlider(
                        items: profileData['banner'].map<Widget>((banner) {
                          return _buildCarouselItem(
                            banner['gambar'],
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
                          viewportFraction: 0.85,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < profileData['banner'].length; i++)
                            Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentCarouselIndex == i
                                    ? const Color.fromARGB(255, 197, 89, 120)
                                    : Colors.grey,
                              ),
                            ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              for (Map<String, dynamic> label in profileData['kategori'])
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  // Spasi antara Chip
                                  child: ActionChip(
                                    label: Text(label['nama'],
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xffC55977))),
                                    onPressed: () {
                                      // Aksi yang diambil saat Chip diklik
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // popular
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Popular',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aksi
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
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: profileData['layanan_populer'].length,
                                itemBuilder: (context, index) {
                                  String muaName = '${profileData['layanan_populer'][index]['nama']}';
                                  String muaLocation = '${profileData['layanan_populer'][index]['lokasi']}';
                                  String muaImage = '${profileData['layanan_populer'][index]['foto']}';

                                  return itemMUA(muaImage: muaImage, muaName: muaName, muaLocation: muaLocation);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // terdekat
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Terdekat',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aksi
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
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: profileData['layanan_terdekat'].length,
                                itemBuilder: (context, index) {
                                  String muaName = '${profileData['layanan_terdekat'][index]['nama']}';
                                  String muaLocation = '${profileData['layanan_terdekat'][index]['lokasi']}';
                                  String muaImage = '${profileData['layanan_terdekat'][index]['foto']}';

                                  return itemMUA(muaImage: muaImage, muaName: muaName, muaLocation: muaLocation);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
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
            icon: Icon(Icons.spa),
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

  Widget _buildCarouselItem(String imagePath) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            imagePath,
            width: 400,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class itemMUA extends StatelessWidget {
  const itemMUA({
    super.key,
    required this.muaImage,
    required this.muaName,
    required this.muaLocation,
  });

  final String muaImage;
  final String muaName;
  final String muaLocation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Aksi ketika card ditekan
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Stack(children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16.0),
                child: Image.network(
                  muaImage,
                  width: 180,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16.0),
                child: Container(
                  width: 180,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xffC55977)
                        .withOpacity(0.2),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            muaName,
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 12.0,
                          ),
                          Text(
                            muaLocation,
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class Product {
  final String imagePath;

  Product(this.imagePath);
}
