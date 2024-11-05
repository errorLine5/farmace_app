// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:farmace_app/pharmacy_page.dart';
import 'package:farmace_app/components/custom_network_image.dart';

List<String> days = [
  "lunedì",
  "martedì",
  "mercoledì",
  "giovedì",
  "venerdì",
  "sabato",
  "domenica"
];

class PharmacyListElement extends StatelessWidget {
  final Map<String, dynamic> data;
  const PharmacyListElement({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // print(data);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PharmacyPage(data: data),
          ),
        );
      },
      child: Container(
          height: 130,
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: (Theme.of(context).brightness == Brightness.dark)
                ? const Color.fromARGB(255, 39, 43, 39)
                : const Color.fromARGB(255, 223, 233, 226),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: CustomNetworkImage(
                      imageUrl: data["image"],
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            data["nome_farmacia"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            data["indirizzo"],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ]),
                  )),
            ]),
          )),
    );
  }
}
