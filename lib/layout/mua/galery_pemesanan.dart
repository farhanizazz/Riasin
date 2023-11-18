import 'package:flutter/material.dart';

class CardGallery extends StatelessWidget {
  const CardGallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          GridView.count(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            children: <Widget>[
              Image.asset("assets/images/wisuda.png", fit: BoxFit.cover),
              Image.asset("assets/images/wisuda.png", fit: BoxFit.cover),
              Image.asset("assets/images/wisuda.png", fit: BoxFit.cover),
              Image.asset("assets/images/wisuda.png", fit: BoxFit.cover),
            ],
          ),
          SizedBox(height: 20),
          Text("Makeup", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor
          )),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
