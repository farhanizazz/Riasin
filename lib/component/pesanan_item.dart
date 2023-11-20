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
    this.onTap, required this.status,
  });

  final String serviceIcon;
  final String clientName;
  final String serviceName;
  final String serviceLocation;
  final String bookingDate;
  final String status;
  final Function()? onTap;

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
      title: Row(
        children: [
          Text(
            clientName,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffE1CCD2),
            ),
            child: Text(
                status,
                style: TextStyle(fontSize: 10, color: Color(0xffC55977)),
              ),
          ),
        ],
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
              Flexible(
                child: Text(
                  serviceName,
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 89, 120),
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 197, 89, 120),
                size: 12.0,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  serviceLocation,
                  style: TextStyle(
                    color: Color.fromARGB(255, 197, 89, 120),
                    fontSize: 10,
                  ),
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
      onTap: onTap,
    );
  }
}
