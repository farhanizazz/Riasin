import 'package:flutter/material.dart';

class KatalogPage extends StatelessWidget {
  const KatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 37),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Preview MUA",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                  onPressed: () {

                  },
                  child: const Text(
                    "Lihat Semua",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ))
            ],
          ),
          // Row(
          //   children: [
          //     Flexible(
          //         flex: 2,
          //         child: Image.network(
          //           "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
          //         )),
          //     Flexible(
          //         flex: 2,
          //         child: Image.network(
          //           "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
          //         )),
          //     Flexible(
          //         flex: 2,
          //         child: Image.network(
          //           "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
          //         )),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Flexible(
          //         flex: 2,
          //         child: Image.network(
          //           "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
          //         )),
          //     Flexible(
          //         flex: 2,
          //         child: Image.network(
          //           "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
          //         )),
          //     Flexible(
          //         flex: 2,
          //         child: Image.network(
          //           "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
          //         )),
          //   ],
          // ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            padding: const EdgeInsets.all(0),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            children: [
              Container(
                color: Color(0xffE1CCD2),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffC55967)),
                          shape: MaterialStateProperty.all(CircleBorder()),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Tambah Foto',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xffC55967)),
                      )
                    ],
                  ),
                ),
              ),
              ...[1, 2, 3, 4, 5].map(
                (e) => Image.network(
                  fit: BoxFit.cover,
                  "https://i.pinimg.com/originals/97/95/50/97955004e0dc75b12bc3f9e72c786044.gif",
                ),
              )
            ],
          ),
          const SizedBox(
            height: 34,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Katalog Jasa",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 15),
          KatalogJasa(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffDFC0C9),
              border: Border.all(color: Color(0xffC55967), width: 1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xffC55967)),
                      shape: MaterialStateProperty.all(CircleBorder()),
                    ),
                  ),
                  Text(
                    'Tambah Jasa',
                    style: TextStyle(fontSize: 10, color: Color(0xffC55967)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
              children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                  .map((e) => Column(
                        children: [
                          KatalogJasa(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text('Test'),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ))
                  .toList())
        ],
      ),
    ));
  }
}

class KatalogJasa extends StatelessWidget {
  const KatalogJasa({
    this.decoration,
    super.key,
    this.child,
  });

  final Decoration? decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Ink(
          decoration: decoration,
          width: double.infinity,
          height: 85,
          child: child),
    );
  }
}
