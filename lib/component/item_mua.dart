import 'package:flutter/material.dart';

class ItemMUA extends StatelessWidget {
  const ItemMUA({
    super.key,
    required this.muaImage,
    required this.muaName,
    required this.muaLocation,
    this.width = 180,
    this.onTap,
  });

  final String muaImage;
  final String muaName;
  final String muaLocation;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: <Widget>[
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  muaImage,
                  width: width,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: width,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xffC55977).withOpacity(0.2),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            muaName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 12.0,
                          ),
                          SizedBox(width: 5),
                          Text(
                            muaLocation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
