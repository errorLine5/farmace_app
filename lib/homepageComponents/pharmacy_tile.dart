import 'dart:math';

import 'package:flutter/material.dart';

class PharmacyTile extends StatelessWidget {
  final double width;
  const PharmacyTile({super.key, this.width = 400});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        width: width - 16,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            //pharmacy informations here
            children: [
              Flex(
                  direction: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Expanded(
                      child: Text(
                        "Pharmacy Name",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ]),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                  child: Text(
                    "Pharmacy Address",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Pharmacy Phone",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
