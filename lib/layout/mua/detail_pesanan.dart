import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class DetailPesanan extends StatelessWidget {
  const DetailPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _genderController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              color: const Color(0xFFECF8F4),
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Padding(
                padding: EdgeInsets.only(top: 50, right: 24, left: 24),
                child: Column(children: [
                  const Card(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Jasa Dipesan"),
                                  Text("Makeup"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Banyak Orang"),
                                  Text("2"),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Total Harga Jasa"),
                                  Text("Rp. 600.000"),
                                ],
                              ),
                            ],
                          ))),
                  const SizedBox(height: 20),
                  Card(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Data Diri Pemesan"),
                              const SizedBox(height: 20),
                              customTextField("Nama Lengkap", _nameController),
                              const SizedBox(height: 20),
                              customTextField(
                                  "Nomor Telepon", _phoneController),
                              const SizedBox(height: 20),
                              customTextField("Gender", _genderController),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _descriptionController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  hintText: "Keterangan atau request tambahan",
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary)),
                                ),
                              )
                            ],
                          ))),
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
                ]),
              )),
        ),
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
        ],
      ),
    );
  }

  TextField customTextField(String label,
      TextEditingController _nameController) {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            fontSize: 16,
          )),
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
