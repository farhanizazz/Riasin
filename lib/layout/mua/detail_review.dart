import 'package:flutter/material.dart';

class CardDetailReview extends StatelessWidget {
  final String clientName;
  final String bookingDate;
  final String serviceType;
  final double rating;
  final String comment;
  final List<dynamic> reviewImages;

  CardDetailReview({
    required this.clientName,
    required this.bookingDate,
    required this.serviceType,
    required this.rating,
    required this.comment,
    required this.reviewImages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Detail Review', style: TextStyle(fontWeight: FontWeight.bold)),
      // ),                                    
      body: SingleChildScrollView(
        child:
         Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Nama Client',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 197, 89, 120),
                                  ),
                                ),
                                Text(
                                  clientName,
                                  style: TextStyle(fontSize: 13, color: Colors.black),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Tanggal Booking',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 197, 89, 120),
                                  ),
                                ),
                                Text(
                                  bookingDate,
                                  style: TextStyle(fontSize: 13, color: Colors.black),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Jenis Jasa',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 197, 89, 120),
                                  ),
                                ),
                                Text(
                                  serviceType,
                                  style: TextStyle(fontSize: 13, color: Colors.black),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Rating',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 197, 89, 120),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => Icon(
                                      i < rating ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                      size: 12.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Komentar',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 197, 89, 120),
                                  ),
                                ),
                                Text(
                                  comment,
                                  style: TextStyle(fontSize: 13, color: Colors.black),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Foto Review',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 197, 89, 120),
                                  ),
                                ),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: reviewImages.map((imageURL) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Image.network(
                                          imageURL,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ]
              )
            ]
          ))));
  }
}
