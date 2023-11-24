import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Url.dart';

class CardDetailReview extends StatefulWidget {
  final String clientName;
  final String bookingDate;
  final String serviceType;
  final double rating;
  final String comment;
  final List<dynamic> reviewImages;
  final int? id;


  CardDetailReview({
    required this.clientName,
    required this.bookingDate,
    required this.serviceType,
    required this.rating,
    required this.comment,
    required this.reviewImages, this.id,
  });

  @override
  State<CardDetailReview> createState() => _CardDetailReviewState();
}

class _CardDetailReviewState extends State<CardDetailReview> {
  final _storage = const FlutterSecureStorage();

  final dio = Dio();

  List? fotoReviews;

  bool _loading = true;

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void getData() async {
    print(widget.id.toString());
    print(await _storage.read(key: 'token'));
    try {
      Response res = await dio.get(
          '$baseUrl/api/pencari-jasa-mua/get-review/${widget.id}',
          options: Options(headers: {
            'Authorization': 'Bearer ${await _storage.read(key: 'token')}'
          }));
      print(res.data);
      setState(() {
        fotoReviews = res.data['data'][0]['foto'];
        _loading = false;
      });
    } on DioException catch (e) {
      showSnackbar(e.response!.data.toString());
      print(e.response!.data.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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
                    child: Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                                  widget.clientName,
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
                                  widget.bookingDate,
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
                                  widget.serviceType,
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
                                      i < widget.rating ? Icons.star : Icons.star_border,
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
                                  widget.comment,
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
                                _loading == true ? Container(
                                  height: 70,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ) : fotoReviews!.isEmpty ? Container(
                                  height: 70,
                                  child: Center(
                                    child: Text(
                                      'Tidak ada foto review',
                                      style: TextStyle(fontSize: 13, color: Colors.black),
                                    ),
                                  ),
                                ) : Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: fotoReviews!.map((imageURL) {
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
