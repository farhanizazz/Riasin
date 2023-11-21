import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';
import 'package:riasin_app/layout/client/detail_mua.dart';
import 'package:riasin_app/layout/client/lihat_semua.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.profileData,
  });

  final Map<String, dynamic> profileData;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCarouselIndex = 0;
  RangeValues _currentRangeValues = const RangeValues(10000, 500000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
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
                          child: Image.network(
                            widget.profileData['client']['foto'],
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          Text(
                            widget.profileData['client']['nama'],
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
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LihatSemua(
                                            data: null,
                                          )));
                            },
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
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LihatSemua(
                                        data: null,
                                      )));
                            },
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                CarouselSlider(
                  items: widget.profileData['banner'].map<Widget>((banner) {
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
                    for (int i = 0;
                        i < widget.profileData['banner'].length;
                        i++)
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
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        for (Map<String, dynamic> label
                            in widget.profileData['kategori'])
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            // Spasi antara Chip
                            child: ActionChip(

                              backgroundColor: Color(0xffD5F0E9),
                              side: const BorderSide(
                                  color: Colors.transparent),
                              label: Text(label['nama'],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffC55977))),
                              onPressed: () {
                                // Aksi yang diambil saat Chip diklik
                                print(label['nama']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LihatSemua(
                                              data: label['layanan'],
                                            )));
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // popular
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Popular',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LihatSemua(
                                            data: widget.profileData[
                                                'layanan_populer'])));
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
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.profileData['layanan_populer']
                              .take(3)
                              .length,
                          itemBuilder: (context, index) {
                            String muaName =
                                '${widget.profileData['layanan_populer'][index]['nama']}';
                            String muaLocation =
                                '${widget.profileData['layanan_populer'][index]['lokasi']}';
                            String muaImage =
                                '${widget.profileData['layanan_populer'][index]['foto']}';

                            return ItemMUA(
                                muaImage: muaImage,
                                muaName: muaName,
                                muaLocation: muaLocation,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailMua(
                                                idMua: widget.profileData[
                                                        'layanan_populer']
                                                    [index]['id'],
                                              )));
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // terdekat
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Terdekat',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LihatSemua(
                                              data: widget.profileData[
                                                  'layanan_terdekat'],
                                            )));
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
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.profileData['layanan_terdekat']
                              .take(3)
                              .length,
                          itemBuilder: (context, index) {
                            String muaName =
                                '${widget.profileData['layanan_terdekat'][index]['nama']}';
                            String muaLocation =
                                '${widget.profileData['layanan_terdekat'][index]['lokasi']}';
                            String muaImage =
                                '${widget.profileData['layanan_terdekat'][index]['foto']}';

                            return ItemMUA(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailMua(
                                          idMua: widget.profileData[
                                          'layanan_terdekat']
                                          [index]['id'],
                                        )));
                              },
                                muaImage: muaImage,
                                muaName: muaName,
                                muaLocation: muaLocation);
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
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
