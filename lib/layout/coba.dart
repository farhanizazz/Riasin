import 'package:flutter/material.dart';
import 'package:riasin_app/main.dart';

class Coba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isReview = true; // kondisi pesanan sudah di beri review atau belum
    String buttonText = isReview ? 'Edit Review' : 'Beri Review';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Review'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/b/be/Joko_Widodo_2019_official_portrait.jpg',
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    'Nama MUA',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(children: [
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.spa,
                          size: 12.0,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'Nama Jasa',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Tanggal Booking: 17-10-2023',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],), 
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        height: 2, 
                        color: primaryColor,
                      ),
                      SizedBox(height: 10), 
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Tambahkan aksi sesuai kondisi
                              if (isReview) {
                                // Aksi jika kondisi A
                              } else {
                                // Aksi jika kondisi B
                              }
                            },
                            child: Text(buttonText, style: TextStyle(fontSize: 12)),
                          ),
                          SizedBox(width: 10), // Jarak antara tombol dan teks
                          InkWell(
                            onTap: () {
                              
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Lihat Review',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: primaryColor,
                                      fontSize: 12
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ), 
                    ],
                  ),
                )
                 
              ],
            ),
            onTap: () {
              // Tambahkan aksi ketika Card ditekan
            },
          ),
        ),

      ),
    );
  }
}
