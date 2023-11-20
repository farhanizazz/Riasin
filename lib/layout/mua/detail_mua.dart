import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:riasin_app/component/custom_outlined_button.dart';
import 'package:riasin_app/layout/mua/galery_pemesanan.dart';
import 'package:riasin_app/main.dart';

class DetailMua extends StatefulWidget {
  const DetailMua({super.key});

  @override
  State<DetailMua> createState() => _DetailMuaState();
}

class _DetailMuaState extends State<DetailMua> {
  int _number = 0;
  List<String> jasa = ["MakeUp", "Nail Art", "Hijab Do"];
  List<String> selectedChips = [];
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    print(_number);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                              .build(context),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text("4.5"),
                          const SizedBox(width: 10),
                          Icon(Icons.location_pin,
                              color: Colors.black.withOpacity(0.5)),
                          Text("Sukolilo, Surabaya"),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.price_change,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 10),
                            Text("Rp 250.000.00 - 500.000.00"),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text("MakeUp",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                          SizedBox(width: 18),
                          InkWell(
                            onTap: () {},
                            child: Text("Nail Art",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                          SizedBox(width: 18),
                          InkWell(
                            onTap: () {},
                            child: Text("Hijab Do",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Jasa Tersedia",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "halohalohalohalohalohalohalohahalohalohalohalohalohalohalohahalohalohalohalohalohalohaloha",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 350,
              child: GridView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: SizedBox(child: CardGallery()),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Review Terbaru',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          // Aksi ketika tombol "Lihat Semua" ditekan
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // ListView untuk daftar review

                ...[1, 1, 1, 1, 1, 1]
                    .map((e) => ReviewItem(
                        imagePath: 'assets/images/mua.jpg',
                        serviceName: 'Pelayanan 1',
                        serviceLocation: 'Lokasi 1',
                        userRating: 1,
                        userReview:
                            'review review review review review review review review review review review'))
                    .toList(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: InkWellWithAnimation(
              color: Colors.white,
              textColor: Colors.pink,
              text: 'Hubungi MUA',
            ),
          ),
          Expanded(
            child: InkWellWithAnimation(
              color: Colors.pink,
              textColor: Colors.white,
              text: 'Pesan Jasa MUA',
              onTap: () {
                // modal bottom sheet
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Scaffold(
                          bottomNavigationBar: Row(
                            children: [
                              Expanded(
                                child: InkWellWithAnimation(
                                    color: Colors.pink,
                                    textColor: Colors.white,
                                    text: 'Pesan MUA',
                                    onTap: () {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text:
                                              "Pesanan penuh pada tanggal yang dipilih!");
                                    }),
                              ),
                              SizedBox()
                            ],
                          ),
                          body: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Harga"), Text("Rp. 10.000")],
                                ),
                                SizedBox(height: 12.0),
                                const Divider(),
                                Row(
                                  children: [
                                    Text("Pesan Jasa"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            children: List<Widget>.generate(
                                              jasa.length,
                                              (int index) {
                                                return ChoiceChip(
                                                  label: Text(jasa[index]),
                                                  selected: selectedChips
                                                      .contains(jasa[index]),
                                                  onSelected: (bool selected) {
                                                    setState(() {
                                                      if (selected) {
                                                        selectedChips
                                                            .add(jasa[index]);
                                                      } else {
                                                        selectedChips.remove(
                                                            jasa[index]);
                                                      }
                                                    });
                                                  },
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ]),
                                  ],
                                ),
                                SizedBox(height: 12.0),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Banyak Orang"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          child: Text("-"),
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              minimumSize: Size(0, 0),
                                              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          onPressed: () {
                                            if (_number <= 0) {
                                              setState(() {
                                                _number = 0;
                                              });
                                            } else {
                                              setState(() {
                                                _number--;
                                              });
                                            }
                                          },
                                        ),
                                        Text(
                                          _number.toString(),
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          child: Text("+"),
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              minimumSize: Size(0, 0),
                                              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          onPressed: () {
                                            setState(() {
                                              _number++;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tanggal Booking"),
                                    IconButton(
                                      color: Theme.of(context).colorScheme.primary,
                                      icon: const Icon(
                                          Icons.calendar_month_rounded),
                                      onPressed: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                                const Duration(days: 365)));
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.imagePath,
    required this.serviceName,
    required this.serviceLocation,
    required this.userRating,
    required this.userReview,
  });

  final String imagePath;
  final String serviceName;
  final String serviceLocation;
  final int userRating;
  final String userReview;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          imagePath,
          width: 35,
          height: 35,
          fit: BoxFit.cover,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.spa,
            color: Color.fromARGB(255, 197, 89, 120),
            size: 12.0,
          ),
          Text(
            serviceName,
            style: TextStyle(
              color: Color.fromARGB(255, 197, 89, 120),
              fontSize: 10,
            ),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.location_on,
            color: Color.fromARGB(255, 197, 89, 120),
            size: 12.0,
          ),
          Text(
            serviceLocation,
            style: TextStyle(
              color: Color.fromARGB(255, 197, 89, 120),
              fontSize: 10,
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              userRating,
              (i) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 12.0,
              ),
            ),
          ),
          Text(
            userReview,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class InkWellWithAnimation extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Function()? onTap;

  InkWellWithAnimation(
      {required this.color,
      required this.textColor,
      required this.text,
      this.onTap});

  @override
  _InkWellWithAnimationState createState() => _InkWellWithAnimationState();
}

class _InkWellWithAnimationState extends State<InkWellWithAnimation> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: isPressed ? widget.color.withOpacity(0.5) : widget.color,
        ),
        child: InkWell(
          // Dalam Ink, gunakan InkWell yang memiliki child
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isPressed ? Colors.grey : widget.textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
