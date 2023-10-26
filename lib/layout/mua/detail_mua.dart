import 'package:flutter/material.dart';
import 'package:riasin_app/component/custom_outlined_button.dart';

class DetailMua extends StatefulWidget {
  const DetailMua({super.key});

  @override
  State<DetailMua> createState() => _DetailMuaState();
}

class _DetailMuaState extends State<DetailMua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/images/profile.jpg'),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 35,
                top: 20,
                right: 35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Farhan's Beauty MakeUp"),
                      CustomOutlinedButton()
                          .setLabel("Lihat Portofolio Saya")
                          .setFontSize(10)
                          .setOnPressed(() {})
                          .build(context)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text("4.5"),
                      const SizedBox(width: 10),
                      Icon(Icons.location_pin,
                          color: Colors.black.withOpacity(0.5)),
                      Text("Sukolilo, Surabaya")
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(
                      Icons.price_change,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    const SizedBox(width: 10),
                    Text("Rp 250.000.00 - 500.000.00"),
                  ]),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 35,
            top: 20,
            right: 35,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Jasa Tersedia",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 35,
            right: 35,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: InkWell(
                  onTap: () {},
                  child: Text("Makeup", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: InkWell(
                  onTap: () {},
                  child: Text("Nail Art", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: InkWell(
                  onTap: () {},
                  child: Text("Hijab Do", style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary
                  )),
                ),
              ),

            ],
          ),
        ),

      ],
    ));
  }
}
