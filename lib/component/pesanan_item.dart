import 'package:flutter/material.dart';
import 'package:riasin_app/layout/mua/order_in_client.dart';

class PesananItem extends StatelessWidget {
  const PesananItem({
    super.key,
    required this.serviceIcon,
    required this.clientName,
    required this.serviceName,
    required this.serviceLocation,
    required this.bookingDate,
  });

  final String serviceIcon;
  final String clientName;
  final String serviceName;
  final String serviceLocation;
  final String bookingDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          serviceIcon,
          width: 35,
          height: 35,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        clientName,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Icon(
                Icons.spa,
                color: Color.fromARGB(255, 197, 89, 120),
                size: 12.0,
              ),
              const SizedBox(width: 5),
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
              const SizedBox(width: 5),
              Text(
                serviceLocation,
                style: TextStyle(
                  color: Color.fromARGB(255, 197, 89, 120),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Text(
            bookingDate,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderInClient(
              nama: 'Farhan Iz',
              nomor: '0812',
              gender: 'Laki-Laki',
              request: 'Request Tambahan untuk MUA',
            ),
          ),
        );
      },
    );
  }
}