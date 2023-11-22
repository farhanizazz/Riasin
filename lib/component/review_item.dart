import 'package:flutter/material.dart';
import 'package:riasin_app/layout/mua/detail_review.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.profilePictureUrl,
    required this.serviceName,
    required this.userRating,
    required this.userReview,
    this.onTap, this.imageReview, required this.tanggalPemesanan,
  });

  final String profilePictureUrl;
  final String serviceName;
  final int userRating;
  final String userReview;
  final List? imageReview;
  final String tanggalPemesanan;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right:10),
      child: Card(
        child: InkWell(
          onTap: onTap,
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
                          profilePictureUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          'Tanggal Booking: ${tanggalPemesanan}',
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                        Row(
                          children: <Widget>[
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
                              Icons.star,
                              color: Colors.amber,
                              size: 12.0,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              userRating.toString(),
                              style: const TextStyle(
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
                imageReview == null ? SizedBox() : Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageReview!.take(3).length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  imageReview![index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  userReview,
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}