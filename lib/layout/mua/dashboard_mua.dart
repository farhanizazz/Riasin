import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardMua extends StatefulWidget {
  @override
  _DashboardMuaState createState() => _DashboardMuaState();
}

class _DashboardMuaState extends State<DashboardMua> {
  int _selectedIndex = 0;
  int _currentCarouselIndex = 0;
  List<Product> products = [
    Product('Nama Produk 1', 'assets/images/mua.jpg', 4.5, 50.0),
    Product('Nama Produk 2', 'assets/images/mua.jpg', 4.0, 40.0),
    Product('Nama Produk 3', 'assets/images/mua.jpg', 4.2, 45.0),
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
                height: MediaQuery.of(context).size.height / 4,
              ),
              SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Profil Pengguna
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nama Pengguna',
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                ),
                                Text(
                                  'Alamat Pengguna', 
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
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
                          ],
                        ),
                      ),

                      CarouselSlider(
                        items: products.map((product) {
                          return _buildCarouselItem(
                            product.name,
                            product.imagePath,
                            product.rating,
                            product.price,
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

                      // Daftar Pesanan
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16.0),
                              child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Pesanan Terbaru',
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
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                String clientName = 'Nama Client $index';
                                String bookingDate = 'Tanggal Booking: 01/01/2023';
                                String serviceName = 'Nama Jasa $index';
                                String serviceLocation = 'Lokasi Jasa $index';
                                String serviceIcon = 'assets/images/profile.jpg'; 

                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      serviceIcon,
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    clientName,
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.spa,
                                            color: Color.fromARGB(255, 197, 89, 120),
                                            size: 12.0,
                                          ),
                                          Text(
                                            serviceName,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 197, 89, 120),
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.location_on,
                                            color: Color.fromARGB(255, 197, 89, 120),
                                            size: 12.0,
                                          ),
                                          Text(
                                            serviceLocation,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 197, 89, 120),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        bookingDate,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                );

                              },
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
                              padding: EdgeInsets.all(16.0),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Review Terbaru',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aksi ketika tombol "Lihat Semua" ditekan
                                    },
                                    child: Text(
                                      'Lihat Semua',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ListView untuk daftar review
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                String serviceName = 'Pelayanan $index';
                                String serviceLocation = 'Lokasi $index';
                                String userReview = 'Isi komentarnya disini lorem ipsum dolor sit amet ...';
                                String imagePath = 'assets/images/mua.jpg'; 
                                int userRating = index + 1; 

                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0), 
                                    child: Image.asset(
                                      imagePath,
                                      width: 35,
                                      height: 35, 
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.spa,
                                        color: Color.fromARGB(255, 197, 89, 120),
                                        size: 12.0,
                                      ),
                                      Text(
                                        serviceName,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 197, 89, 120),
                                          fontSize: 10,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.location_on,
                                        color: Color.fromARGB(255, 197, 89, 120),
                                        size: 12.0,
                                      ),
                                      Text(
                                        serviceLocation,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 197, 89, 120),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: List.generate(
                                          userRating,
                                          (i) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 12.0,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        userReview,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                );
                              },
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

  Widget _buildCarouselItem(String name, String imagePath, double rating, double price) {
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
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: 300,
            height: 130,
            decoration: BoxDecoration(
              color: Color(0xffC55977).withOpacity(0.3),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12.0,
                    ),
                    Text(
                      rating.toString(), 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Harga: Rp ${price.toStringAsFixed(3)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}


class Product {
  final String name;
  final String imagePath;
  final double rating;
  final double price;

  Product(this.name, this.imagePath, this.rating, this.price);
}
