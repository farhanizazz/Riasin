import 'package:flutter/material.dart';
import 'package:riasin_app/main.dart';
// import 'package:riasin_app/layout/client/review_pesanan.dart';

class PesananItemReview extends StatelessWidget {
  final String serviceIcon;
  final String muaName;
  final String serviceName;
  final String bookingDate;
  final bool isReview; // kondisi pesanan sudah di beri review atau belum
  final Function() onTap;

  const PesananItemReview({
    super.key,
    required this.serviceIcon,
    required this.muaName,
    required this.serviceName,
    required this.bookingDate,
    required this.isReview,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      // child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  serviceIcon,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                muaName,
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
                        serviceName,
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
                      'Tanggal Booking: $bookingDate',
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
                        onPressed: onTap,
                        child: Text(isReview ? 'Edit Review' : 'Beri Review', style: TextStyle(fontSize: 12)),
                      ),
                      SizedBox(width: 10), 
                      isReview ? InkWell(
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
                      ): const SizedBox(),
                    ],
                  ), 
                ],
              ),
            )
          ],
        // ),
        // onTap: () {
        //   // Tambahkan aksi ketika Card ditekan
        // },
      ),
    );
  }
}