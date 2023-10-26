import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';
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

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                  for (int i = 0; i < widget.profileData['banner'].length; i++)
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

              // Container(
              //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: <Widget>[
              //         for (Map<String, dynamic> label
              //             in profileData['kategori'])
              //           Padding(
              //             padding: const EdgeInsets.all(2.0),
              //             // Spasi antara Chip
              //             child: ActionChip(
              //               backgroundColor: Color(0xffD5F0E9),
              //               side: const BorderSide(
              //                   color: Colors.transparent),
              //               label: Text(label['nama'],
              //                   style: const TextStyle(
              //                       fontSize: 10,
              //                       color: Color(0xffC55977))),
              //               onPressed: () {
              //                 // Aksi yang diambil saat Chip diklik
              //               },
              //             ),
              //           ),
              //       ],
              //     ),
              //   ),
              // ),

              // popular
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
                            'Popular',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const lihatSemua()));
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
                        itemCount: widget.profileData['layanan_populer'].length,
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
                              muaLocation: muaLocation);
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
                                      builder: (context) =>
                                      const lihatSemua()));
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
                        itemCount:
                        widget.profileData['layanan_terdekat'].length,
                        itemBuilder: (context, index) {
                          String muaName =
                              '${widget.profileData['layanan_terdekat'][index]['nama']}';
                          String muaLocation =
                              '${widget.profileData['layanan_terdekat'][index]['lokasi']}';
                          String muaImage =
                              '${widget.profileData['layanan_terdekat'][index]['foto']}';

                          return ItemMUA(
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
    ]);
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