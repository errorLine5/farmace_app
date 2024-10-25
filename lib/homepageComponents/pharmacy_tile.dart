import 'package:farmace_app/homepageComponents/isopenpill.dart';
import 'package:flutter/material.dart';

class PharmacyTile extends StatelessWidget {
  final double width;
  const PharmacyTile({super.key, this.width = 380});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        width: width - 16,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://picsum.photos/900/900",
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  //pharmacy informations here
                  children: [
                    Flex(
                        direction: Axis.horizontal,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Expanded(
                            child: Text(
                              "Farmacia Bolli",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: "",
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ]),
                    Flex(direction: Axis.horizontal, children: [
                      Expanded(
                        flex: 2,
                        child: Text("Via Corso Vittorio Emanuele II",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ]),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        child: Flex(direction: Axis.horizontal, children: [
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 3,
                        child: Isopenpill(),
                      )
                    ])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
