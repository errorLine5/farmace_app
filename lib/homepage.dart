import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:farmace_app/homepageComponents/pharmacy_list_element.dart';
import 'package:farmace_app/homepageComponents/pharmacy_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Homepage extends StatefulWidget {
  void Function() toggleTheme = () {};
  Homepage({required this.toggleTheme, super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(
      initialScrollOffset: 200,
      onAttach: (position) {
        position.addListener(() {
          // ignore: avoid_print
          print("${position.pixels} ${position.maxScrollExtent}");

          if (position.userScrollDirection == ScrollDirection.reverse) {
            print("reverse");
            if (position.pixels > 100 && position.pixels < 300) {
              position.animateTo(300,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeInOut);
            }
          }
          if (position.userScrollDirection == ScrollDirection.forward) {
            print("forward");
            if (position.pixels > 300 && position.pixels < 600) {
              position.animateTo(300,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeInOut);
            }
            if (position.pixels < 200 && position.pixels > 0) {
              position.animateTo(0,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeInOut);
            }
          }
        });
        position.animateTo(300,
            duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
      },
    );
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BlurryContainer(
          borderRadius: BorderRadius.circular(0),
          color: Theme.of(context).appBarTheme.backgroundColor!.withAlpha(204),
          blur: 10,
          height: 70,
          width: 250,
          child: const Flex(direction: Axis.horizontal, children: [
            Spacer(),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Spacer(
              flex: 2,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            Spacer(flex: 2),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            Spacer(),
          ])),
      body: CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              expandedHeight: 350,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

              pinned: true,
              collapsedHeight: 70,

              elevation: 1,
              //put in the flexible space user info
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Flex(
                  direction: Axis.vertical,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                            "https://picsum.photos/800/900",
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Flex(
                      direction: Axis.horizontal,
                      children: [
                        Spacer(),
                        Text(
                          "User Name",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            fontFamily: "OpenSans",
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Spacer(),
                      ],
                    ),
                    const Flex(
                      direction: Axis.horizontal,
                      children: [
                        Spacer(),
                        Text(
                          "placeholdermail.@gmail.com",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                            fontFamily: "OpenSans",
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Spacer(),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),

              title: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(
                        flex: 8,
                        child: Text("Farmace",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left)),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: IconButton(
                          onPressed: () {
                            widget.toggleTheme();
                          },
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.dark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny, // Icon for dark theme
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 14, top: 20, right: 14),
                child: Text(
                  "Open now",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontFamily: "OpenSans",
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    PharmacyTile(width: 380),
                    PharmacyTile(),
                    PharmacyTile(),
                    PharmacyTile(),
                    PharmacyTile(),
                  ],
                ),
              ),
            ])),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Next to you",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontFamily: "OpenSans",
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [for (int i = 0; i < 20; i++) const PharmacyListElement()],
              ),
            ),
          ]),
    );
  }
}
