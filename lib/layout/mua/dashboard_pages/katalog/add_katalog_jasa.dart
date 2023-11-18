import 'package:flutter/material.dart';
import 'package:riasin_app/component/widget_tombol_registrasi_bawah.dart';

class KatalogJasa extends StatefulWidget {
  const KatalogJasa({super.key});

  @override
  State<KatalogJasa> createState() => _KatalogJasaState();
}

class _KatalogJasaState extends State<KatalogJasa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Preview MUA",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .copyWith(bottom: 40, top: 10),
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 13, color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.3)),
                        hintText: "Masukkan nama jasa anda",
                        labelText: "Nama Jasa",
                      ),
                      items: [
                        DropdownMenuItem(child: Text("Paket 1"), value: 1),
                        DropdownMenuItem(child: Text("Paket 1"), value: 1),
                        DropdownMenuItem(child: Text("Paket 1"), value: 1),
                        DropdownMenuItem(child: Text("Paket 1"), value: 1),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 13, color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.3)),
                        hintText: "Masukkan nama jasa anda",
                        labelText: "Nama Jasa",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 13, color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.3)),
                        hintText: "Masukkan nama jasa anda",
                        labelText: "Nama Jasa",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              WidgetTombolRegistrasiBawah(
                nextPageOnTap: () {},
                nextPageName: "Tambah",
                previousPageName: "Batal",
                usePrevButton: false,
                useNextArrow: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
