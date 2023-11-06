import 'package:flutter/material.dart';
import 'package:riasin_app/component/inkwell_animation.dart';
// import 'package:riasin_app/main.dart';

class ReviewPesanan extends StatefulWidget {
  @override
  _ReviewPesananState createState() => _ReviewPesananState();
}

class _ReviewPesananState extends State<ReviewPesanan> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beri Review', style: TextStyle(fontWeight: FontWeight.bold)),
      ),                                    
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child:Column(children: [
                    Card(
                      elevation: 4,
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: 
                              Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jasa MUA',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        'muaName',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10), 
                                      Text(
                                        'Jenis Jasa',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        'serviceName',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10), 
                                      Text(
                                        'Tanggal Booking',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      Text(
                                        'serviceDate',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 4,
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jasa MUA',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 197, 89, 120)),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: List.generate(5, (index) {
                                          final isFilled = index < rating;
                                          final fillColor = isFilled ? Colors.amber : Color.fromARGB(255, 164, 143, 143);
                                          final borderColor = Colors.amber; 

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                rating = index + 1;
                                              });
                                            },
                                            child: Opacity(
                                              opacity: isFilled ? 1.0 : 0.5,
                                              child: Icon(
                                                Icons.star,
                                                color: fillColor,
                                                size: 30, // Ukuran bintang
                                                semanticLabel: 'Rating $rating of 5',
                                                key: Key('rating_$rating'),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Testimoni Jasa',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(255, 197, 89, 120),
                                            ),
                                          ),
                                          SizedBox(width: 10), 
                                          Text(
                                            '(Maks 5 foto)',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                              color: Color.fromARGB(255, 197, 89, 120), 
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],) 
                ),
              ],
            ),
          ],
        )
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: InkWellWithAnimation(
              color: Color.fromARGB(255, 197, 89, 120),
              textColor: Colors.white,
              text: 'Beri Review',
            ),
          ),
        ],
      ),
    );
  }
}
