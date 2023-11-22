import 'package:flutter/material.dart';

class CardGallery extends StatelessWidget {

  final String title;
  final List imageUrls;

  const CardGallery({
    super.key, required this.title, required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: imageUrls.length == 1 ? 1 : 2,
            children: <Widget>[
              for (var i = 0; i < imageUrls.length; i++)
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imageUrls[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          Text(title, style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor
          )),
        ],
      ),
    );
  }
}
