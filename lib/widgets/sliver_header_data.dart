import 'package:flutter/material.dart';

class SliverHeaderData extends StatelessWidget {
  const SliverHeaderData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Homemade. Deserts. Asian',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: const [
              Icon(
                Icons.access_time,
                size: 14,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
               '30-40 Min 4.3',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.star,
                size: 14,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '\$5.50 fee',
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
