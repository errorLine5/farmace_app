import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class PharmacyPage extends StatefulWidget {
  Map<String, dynamic> data;
  PharmacyPage({super.key, required this.data});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

double basepos = 0.11;
double width_multiplier = 0.9;

class _PharmacyPageState extends State<PharmacyPage> {
  ScrollController scrollController = ScrollController();
  double elementTitlePosition = basepos;
  //0.5 is max position
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(
      initialScrollOffset: 0,
      onAttach: (position) {
        position.addListener(() {
          double vPos = position.pixels;
          setState(() {
            elementTitlePosition = basepos - (vPos / 100) * 0.20;
            width_multiplier = 0.93 + (vPos / 120) * 0.1;

            if (elementTitlePosition >= basepos + .1) {
              position.animateTo(5,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            }
            if (elementTitlePosition >= basepos + .2) {
              elementTitlePosition = basepos;
            }
          });
        });
      },
    );

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: (Theme.of(context).brightness == Brightness.dark)
            ? Theme.of(context).primaryColor
            : Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        "https://picsum.photos/800/900",
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        color: Theme.of(context).primaryColor.withAlpha(100),
                        colorBlendMode: BlendMode.multiply,
                      ),
                    ),
                    expandedHeight: 150,
                    collapsedHeight: 150,
                    backgroundColor:
                        Theme.of(context).primaryColor.withAlpha(180)),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).primaryColor.withAlpha(180),
                    height: 120,
                  ),
                ),
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    snap: true,
                    pinned: true,
                    forceMaterialTransparency: true,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: BlurryContainer(
                        blur: 80,
                        color: Theme.of(context).primaryColor.withAlpha(220),
                        child: SizedBox(
                          width: width,
                          height: 90,
                        ),
                      ),
                    ),
                    title: OverflowBox(
                      fit: OverflowBoxFit.deferToChild,
                      child: BlurryContainer(
                        width: width,
                        height: 90,
                        color: Theme.of(context).primaryColor.withAlpha(180),
                        padding: const EdgeInsets.all(0),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 100,
                            children: [
                              for (var i = 0; i < 10; i++)
                                Chip(
                                  label: Text("Item filter $i"),
                                  padding: const EdgeInsets.all(2),
                                )
                            ]),
                      ),
                    )),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      children: [
                        for (var i = 0; i < 20; i++)
                          ListTile(
                            title: Text("Item $i"),
                          ),
                      ]),
                )),
              ],
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: AnimatedSlide(
                offset: Offset(0, elementTitlePosition),
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                        SizedBox(
                          width: width * 0.75,
                          child: Text(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.data["nome_farmacia"],
                            style: const TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(0, 0),
                                    blurRadius: 30)
                              ],
                              fontFamily: "Poppins",
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlurryContainer(
                        height: 220,
                        width: width * width_multiplier,
                        blur: (Theme.of(context).brightness == Brightness.dark)
                            ? 10
                            : 40,
                        borderRadius: BorderRadius.circular(
                            (20 / 0.80) * width_multiplier),
                        elevation: 5,
                        color: Theme.of(context).primaryColor.withAlpha(180),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.data["indirizzo"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${widget.data['orari'].toString()} }",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.data["numeri"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.language,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.data["sito_web"] ??
                                        "Sito web non disponibile",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
