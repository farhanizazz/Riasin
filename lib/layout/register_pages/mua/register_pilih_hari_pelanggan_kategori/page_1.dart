import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/component/pilihan_hari.dart';
import 'package:riasin_app/providers/form_data_provider.dart';

class Page1 extends StatefulWidget {
  const Page1({
    super.key,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late FormData? _formData;

  addHari(String hari) {
    setState(() {
      _formData?.setHari(hari);
    });
  }

  @override
  void initState() {
    _formData = Provider.of<FormData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FormData _formData = Provider.of<FormData>(context, listen: false);

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
                        isSelected: _formData.hari.contains('Senin'),
                        onTap: (() {
                          addHari("Senin");
                        }),
                      ),
                      PilihanHari(
                        hari: "Selasa",
                        isSelected: _formData.hari.contains('Selasa'),
                        onTap: (() {
                          addHari("Selasa");
                        }),
                      ),
                      PilihanHari(
                        hari: "Rabu",
                        isSelected: _formData.hari.contains('Rabu'),
                        onTap: (() {
                          addHari("Rabu");
                        }),
                      ),
                      PilihanHari(
                        hari: "Kamis",
                        isSelected: _formData.hari.contains('Kamis'),
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
                        isSelected: _formData.hari.contains("Jumat"),
                        onTap: (() {
                          addHari("Jumat");
                        }),
                      ),
                      PilihanHari(
                        hari: "Sabtu",
                        isSelected: _formData.hari.contains('Sabtu'),
                        onTap: (() {
                          addHari("Sabtu");
                        }),
                      ),
                      PilihanHari(
                        hari: "Minggu",
                        isSelected: _formData.hari.contains('Minggu'),
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
