import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riasin_app/providers/form_data_provider.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late FormData _formData;
  TextEditingController _jumlahCustomer = TextEditingController();


  void initState() {
    final FormData _formData = Provider.of<FormData>(context, listen: false);
    _jumlahCustomer.text = _formData.jumlahOrderan;

    super.initState();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Masukkan jumlah pelanggan yang bisa Anda layani per harinya",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffC55977),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xffE1CCD2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _jumlahCustomer,
                onChanged: (value) {
                  setState(() {
                    _formData.changeJumlahOrderan(value);
                  });
                },
                style: const TextStyle(
                  color: Color(0xffC55977),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
