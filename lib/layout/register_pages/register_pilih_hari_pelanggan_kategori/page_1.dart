import 'package:flutter/material.dart';
import 'package:riasin_app/component/pilihan_hari.dart';

class Page1 extends StatefulWidget {
  const Page1({
    super.key,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List hari = [];

  addHari(String hari) {
    setState(() {
      if (this.hari.contains(hari)) {
        this.hari.remove(hari);
        return;
      }
      this.hari.add(hari);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffE9ECEC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                const Text(
                  "Pilih hari yang tersedia\nuntuk menerima orderan",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffC55977),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Center(
                  child: Wrap(
                    spacing: 10,
                    children: [
                      PilihanHari(
                        hari: "Senin",
                        isSelected: hari.contains('Senin'),
                        onTap: (() {
                          addHari("Senin");
                        }),
                      ),
                      PilihanHari(
                        hari: "Selasa",
                        isSelected: hari.contains('Selasa'),
                        onTap: (() {
                          addHari("Selasa");
                        }),
                      ),
                      PilihanHari(
                        hari: "Rabu",
                        isSelected: hari.contains('Rabu'),
                        onTap: (() {
                          addHari("Rabu");
                        }),
                      ),
                      PilihanHari(
                        hari: "Kamis",
                        isSelected: hari.contains('Kamis'),
                        onTap: (() {
                          addHari("Kamis");
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      PilihanHari(
                        hari: "Jumat",
                        isSelected: hari.contains("Jumat"),
                        onTap: (() {
                          addHari("Jumat");
                        }),
                      ),
                      PilihanHari(
                        hari: "Sabtu",
                        isSelected: hari.contains('Sabtu'),
                        onTap: (() {
                          addHari("Sabtu");
                        }),
                      ),
                      PilihanHari(
                        hari: "Minggu",
                        isSelected: hari.contains('Minggu'),
                        onTap: (() {
                          addHari("Minggu");
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
