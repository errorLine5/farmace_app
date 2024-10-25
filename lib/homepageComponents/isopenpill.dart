import 'dart:ui';
import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:flutter/material.dart';

class Isopenpill extends StatelessWidget {
  const Isopenpill({super.key});

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      borderRadius: BorderRadius.circular(90),
      color: Theme.of(context).primaryColor.withAlpha(100),
      blur: 4,
      height: 40,
      width: 250,
      child: const Center(
          child: Text(
        textAlign: TextAlign.center,
        "Open monday at 9:30",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
