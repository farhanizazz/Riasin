import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/component/filter_kategori.dart';
import 'package:riasin_app/providers/form_data_provider.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  List<String> kategori = [];
  late FormData _formData;

  void initState() {
    _formData = Provider.of<FormData>(context, listen: false);
    kategori = _formData.kategori;

    super.initState();
  }

  void setKategori(String value) {
    setState(() {
      _formData.setKategori(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final FormData _formData = Provider.of<FormData>(context, listen: false);

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
                    kategori: _formData.kategori, nama: "Make Up", value: "1", onSelected: (value) {
                      setKategori("1");
                },),
                FilterKategori(
                    kategori: _formData.kategori, nama: "Hair Do", value: "2", onSelected: (value) {
                      setKategori("2");}),
                FilterKategori(kategori: kategori, nama: "Hena", value: "3", onSelected: (value) {
                      setKategori("3");}),
                FilterKategori(
                    kategori: _formData.kategori, nama: "Hijab Do", value: "4", onSelected: (value) {
                      setKategori("4");}),
                FilterKategori(
                    kategori: _formData.kategori, nama: "Nail Art", value: "5", onSelected: (value) {
                      setKategori("5");}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
