import 'package:flutter/material.dart';

class Coba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Card Review Di Dshboard MUA'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // Card 1
                  InkWell(
                    onTap: () {
                      // Tambahkan aksi ketika card ditekan
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column( // Ganti dari Row() menjadi Column()
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/b/be/Joko_Widodo_2019_official_portrait.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Tanggal Booking: 17 Agustus 1945',
                                      style: TextStyle(fontSize: 10, color: Colors.black),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.spa,
                                          color: Color.fromARGB(255, 197, 89, 120),
                                          size: 12.0,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'make up',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 197, 89, 120),
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 12.0,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 197, 89, 120),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: List<Widget>.generate(3, (int index) {
                                return Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/b/be/Joko_Widodo_2019_official_portrait.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Isi komentarnya disini lorem ipsum dolor sit amet ...',
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
