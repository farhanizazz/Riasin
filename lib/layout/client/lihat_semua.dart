import 'package:flutter/material.dart';
import 'package:riasin_app/component/item_mua.dart';

class lihatSemua extends StatelessWidget {
  const lihatSemua({super.key});

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
          children: [1, 1, 1, 1, 1, 1, 1]
              .map(
                (e) => const SizedBox(
                    width: double.infinity,
                    child: ItemMUA(
                        muaName: "Test",
                        muaLocation: "Test",
                        muaImage:
                            "https://i0.wp.com/www.printmag.com/wp-content/uploads/2021/02/4cbe8d_f1ed2800a49649848102c68fc5a66e53mv2.gif?fit=476%2C280&ssl=1",
                        width: double.infinity)),
              )
              .toList(),
        ),
      ),
    );
  }
}
