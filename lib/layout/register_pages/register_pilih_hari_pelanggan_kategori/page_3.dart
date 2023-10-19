import 'package:flutter/material.dart';
import 'package:riasin_app/component/filter_kategori.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  List<String> kategori = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE9ECEC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            const Column(
              children: [
                Text(
                  "Jenis pelayanan apa saja yang kamu layani?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffC55977),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              children: [
                FilterKategori(
                    kategori: kategori, nama: "Make Up", value: "Make Up"),
                FilterKategori(
                    kategori: kategori, nama: "Hair Do", value: "Hair Do"),
                FilterKategori(kategori: kategori, nama: "Hena", value: "Hena"),
                FilterKategori(
                    kategori: kategori, nama: "Hijab Do", value: "Hijab Do"),
                FilterKategori(
                    kategori: kategori, nama: "Nail Art", value: "Nail Art"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
