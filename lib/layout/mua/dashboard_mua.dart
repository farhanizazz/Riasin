import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:riasin_app/layout/mua/order_in_client.dart';

class DashboardMua extends StatefulWidget {
  @override
  _DashboardMuaState createState() => _DashboardMuaState();
}

class _DashboardMuaState extends State<DashboardMua> {
  int _selectedIndex = 0;
  int _currentCarouselIndex = 0;
  List<CarouselItem> products = [
    CarouselItem('Nama Produk 1', 'assets/images/mua.jpg', 4.5, 50.0),
    CarouselItem('Nama Produk 2', 'assets/images/mua.jpg', 4.0, 40.0),
    CarouselItem('Nama Produk 3', 'assets/images/mua.jpg', 4.2, 45.0),
  ];

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: const Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Nama Jasa",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Kecamatan lokasi jasa",
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
                  items: products.map((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: _buildCarouselItem(
                        product.name,
                        product.imagePath,
                        product.rating,
                        product.price,
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
                    for (int i = 0; i < products.length; i++)
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
                              onPressed: () {
                                // Aksi
                              },
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...[1, 2, 3].map((e) => pesananItem(
                          serviceIcon: 'assets/images/profile.jpg',
                          clientName: 'Nama Client $e',
                          serviceName: 'Nama Jasa $e',
                          serviceLocation: 'Lokasi Jasa $e',
                          bookingDate: 'Tanggal Booking: 01/01/2023'))
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
                                // Aksi ketika tombol "Lihat Semua" ditekan
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
                      // ListView untuk daftar review
                      ...[1, 2, 3].map((e) => ReviewItem(
                          imagePath: 'assets/images/mua.jpg',
                          serviceName: 'Pelayanan $e',
                          serviceLocation: 'Lokasi $e',
                          userRating: e,
                          userReview:
                              'Isi komentarnya disini lorem ipsum dolor sit amet ...'))
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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Pesanan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: 'Katalog',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(
      String name, String imagePath, double rating, double price) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(children: [
            Image.asset(
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

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.imagePath,
    required this.serviceName,
    required this.serviceLocation,
    required this.userRating,
    required this.userReview,
  });

  final String imagePath;
  final String serviceName;
  final String serviceLocation;
  final int userRating;
  final String userReview;

  @override
  Widget build(BuildContext context) {
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
          const Icon(
            Icons.spa,
            color: Color.fromARGB(255, 197, 89, 120),
            size: 12.0,
          ),
          const SizedBox(width: 5),
          Text(
            serviceName,
            style: const TextStyle(
              color: Color.fromARGB(255, 197, 89, 120),
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.location_on,
            color: Color.fromARGB(255, 197, 89, 120),
            size: 12.0,
          ),
          const SizedBox(width: 5),
          Text(
            serviceLocation,
            style: const TextStyle(
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
              (i) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12.0,
              ),
            ),
          ),
          Text(
            userReview,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class pesananItem extends StatelessWidget {
  const pesananItem({
    super.key,
    required this.serviceIcon,
    required this.clientName,
    required this.serviceName,
    required this.serviceLocation,
    required this.bookingDate,
  });

  final String serviceIcon;
  final String clientName;
  final String serviceName;
  final String serviceLocation;
  final String bookingDate;

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(width: 5),
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
              const SizedBox(width: 5),
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderInClient(
              nama: 'Farhan Iz',
              nomor: '0812',
              gender: 'Laki-Laki',
              request: 'Request Tambahan untuk MUA',
            ),
          ),
        );
      },
    );
  }
}

class CarouselItem {
  final String name;
  final String imagePath;
  final double rating;
  final double price;

  CarouselItem(this.name, this.imagePath, this.rating, this.price);
}
