import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';

class lihatSemua extends StatelessWidget {
  const lihatSemua({super.key, required this.data});
  final List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Lihat Semua",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: data
              .map(
                (e) => SizedBox(
                    width: double.infinity,
                    child: ItemMUA(
                        muaName: e['nama'],
                        muaLocation: e['lokasi'],
                        muaImage:
                            e['foto'],
                        width: double.infinity)),
              )
              .toList(),
        ),
      ),
    );
  }
}
