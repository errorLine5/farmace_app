import 'package:flutter/material.dart';
import 'package:farmace_app/pharmacy_page.dart';

class PharmacyListElement extends StatelessWidget {
  const PharmacyListElement({super.key});

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (event) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PharmacyPage(),
          ),
        );
      },
      child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: (Theme.of(context).brightness == Brightness.dark)
                ? const Color.fromARGB(255, 39, 43, 39)
                : const Color.fromARGB(255, 223, 233, 226),
          ),
          child: Flex(direction: Axis.horizontal, children: [
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image(
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                    image: NetworkImage(
                      "https://picsum.photos/900/900",
                    ),
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
                          textAlign: TextAlign.left,
                          "Farmacia Bolli",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Via Corso Vittorio Emanuele II",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Aperto fino alle 23pm",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ]),
                )),
          ])),
    );
  }
}
