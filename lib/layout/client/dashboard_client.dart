import 'package:flutter/material.dart';
import 'package:riasin_app/layout/mua/dashboard_mua.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardClient extends StatefulWidget {
  @override
  _DashboardClientState createState() => _DashboardClientState();
}

class _DashboardClientState extends State<DashboardClient> {
  List<String> chipLabels = ['Semua', 'Make Up', 'Hair Do', 'Hijab Do', 'Nail Art'];
  String? selectedFilter = 'Semua';
  List<String> filterOptions = ['Semua', 'Paket 1', 'Paket 2', 'Paket 3'];
  int _selectedIndex = 0; 
  int _currentCarouselIndex = 0;
  List<Product> products = [
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
    Product('assets/images/mua.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: Color(0xFFC55977), 
                height: MediaQuery.of(context).size.height / 3,
              ),
              SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Profil Pengguna
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 50, 
                                height: 50, 
                                child: Image.asset(
                                  'assets/images/profile.jpg', 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10), 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Hi,',
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                                Text(
                                  'Nama Client',
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Kolom Pencarian dan Filter
                      Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextField(
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
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(10.0), 
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
                                        child: Text("Filter 1"),
                                        onTap: () {
                                          // Aksi untuk Filter 1
                                        },
                                      ),
                                      PopupMenuItem<String>(
                                        value: "filter2",
                                        child: Text("Filter 2"),
                                        onTap: () {
                                          // Aksi untuk Filter 2
                                        },
                                      ),
                                      PopupMenuItem<String>(
                                        value: "filter3",
                                        child: Text("Filter 3"),
                                        onTap: () {
                                          // Aksi untuk Filter 3
                                        },
                                      ),
                                    ];
                                  },
                                  child: Icon(Icons.filter_list, color: Colors.white), // Warna pink
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      CarouselSlider(
                        items: products.map((product) {
                          return _buildCarouselItem(
                            product.imagePath,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                          for (int i = 0; i < products.length; i++)
                            Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentCarouselIndex == i ? Color.fromARGB(255, 197, 89, 120) : Colors.grey,
                              ),
                            ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              for (String label in chipLabels)
                                Padding(
                                  padding: const EdgeInsets.all(2.0), // Spasi antara Chip
                                  child: ActionChip(
                                    label: Text(label, style: TextStyle(fontSize: 10, color: Color(0xffC55977))),
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
                        padding: EdgeInsets.all(16.0), 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Popular',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aksi 
                                    },
                                    child: Text(
                                      'Lihat Semua',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  String muaName = 'Nama MUA $index';
                                  String muaLocation = 'Lokasi MUA $index';
                                  String muaImage = 'assets/images/mua.jpg';

                                  return InkWell(
                                    onTap: () {
                                      // Aksi ketika card ditekan
                                    },
                                    child: Card(
                                      child: Column(
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: Image.asset(
                                                  muaImage,
                                                  width: 180,
                                                  height: 110,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: Container(
                                                  width: 180,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffC55977).withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 10,
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            muaName,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                           Icon(
                                                            Icons.location_on,
                                                            color: Colors.white,
                                                            size: 12.0,
                                                          ),
                                                          Text(
                                                            muaLocation, 
                                                            style: TextStyle(
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
                                            ]
                                          ) 
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // terdekat
                      Container(
                        padding: EdgeInsets.all(16.0), 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Terdekat',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aksi 
                                    },
                                    child: Text(
                                      'Lihat Semua',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5, 
                                itemBuilder: (context, index) {
                                  String muaName = 'Nama MUA $index';
                                  String muaLocation = 'Lokasi MUA $index';
                                  String muaImage = 'assets/images/mua.jpg';

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DashboardMua()), 
                                      );
                                    },
                                    child: Card(
                                      child: Column(
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: Image.asset(
                                                  muaImage,
                                                  width: 180,
                                                  height: 110,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: Container(
                                                  width: 180,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffC55977).withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 10,
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            muaName,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                           Icon(
                                                            Icons.location_on,
                                                            color: Colors.white,
                                                            size: 12.0,
                                                          ),
                                                          Text(
                                                            muaLocation, 
                                                            style: TextStyle(
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
                                            ]
                                          ) 
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ]
      ),
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
        selectedItemColor: Color(0xffC55977),
        unselectedItemColor: Colors.grey,
        items: [
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
          child: Image.asset(
            imagePath,
            width: 300,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }


}


class Product {
  final String imagePath;

  Product(this.imagePath);
}
