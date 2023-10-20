import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // Index aktif di BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MUA Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Tambahkan aksi saat tombol pencarian ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Carousel untuk iklan
            CarouselSlider(
              items: [
                _buildCarouselItem('assets/images/mua.jpg', 'Rating: 4.5 | Harga: \$50'),
                _buildCarouselItem('assets/images/mua.jpg', 'Rating: 4.0 | Harga: \$40'),
                _buildCarouselItem('assets/images/mua.jpg', 'Rating: 4.2 | Harga: \$45'),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),

            // Daftar Jasa MUA yang bisa digeser
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Daftar Jasa MUA',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Aksi ketika tombol "Lihat Semua" ditekan
                          },
                          child: Text('Lihat Semua'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 200, // Tinggi card jasa MUA
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Membuat list horizontal
                      itemCount: 5, // Ganti dengan jumlah jasa MUA yang sesuai
                      itemBuilder: (context, index) {
                        // Ganti data berikut sesuai dengan data jasa MUA yang sesuai
                        String muaName = 'Nama MUA $index';
                        String muaDescription = 'Deskripsi MUA $index';
                        String muaImage = 'assets/images/mua.jpg'; // Ganti dengan path gambar lokal

                        return InkWell(
                          onTap: () {
                            // Aksi ketika card jasa MUA ditekan
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  muaImage,
                                  // width: double.infinity, // Lebar penuh card
                                  width: 200, // Lebar penuh card
                                  height: 120, // Tinggi card MUA
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(muaName),
                                      Text(muaDescription),
                                    ],
                                  ),
                                ),
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
            
            // ListView untuk review jasa
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Review Jasa',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          // Aksi ketika tombol "Lihat Semua" di review ditekan
                        },
                        child: Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // ListView untuk daftar review
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5, // Ganti dengan jumlah review yang sesuai
                    itemBuilder: (context, index) {
                      // Ganti data berikut sesuai dengan data review yang sesuai
                      String userName = 'Pengguna $index';
                      String userReview = 'Review $index';
                      String imagePath = 'assets/images/mua.jpg'; // Ganti dengan path gambar lokal
                      int userRating = index + 1; // Ganti dengan rating yang sesuai

                      return ListTile(
                        leading: Image.asset(imagePath),
                        title: Text(userName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(
                                userRating,
                                (i) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                            Text(userReview),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
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

  Widget _buildCarouselItem(String imageUrl, String description) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 200, // Sesuaikan tinggi sesuai kebutuhan
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              description,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
