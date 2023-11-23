import 'package:flutter/material.dart';

class DetailGaleri extends StatelessWidget {
  const DetailGaleri({super.key, required this.photos});

  final List photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail Galeri', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0).copyWith(top: 33),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          padding: const EdgeInsets.all(0),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            ...photos.map(
                  (e) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      e,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
