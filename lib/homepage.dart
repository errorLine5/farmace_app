import 'package:farmace_app/homepageComponents/pharmacy_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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
          if (position.userScrollDirection == ScrollDirection.forward) {
            if (position.pixels > 100 && position.pixels > 300) {
              position.animateTo(0,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut);
            }
          } else if (position.userScrollDirection == ScrollDirection.reverse) {
            if (position.pixels < 100 && position.pixels < 300) {
              position.animateTo(280,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut);
            }
          }
          // if (position.pixels < 100 &&
          //     position.userScrollDirection == ScrollDirection.idle) {
          //   position.animateTo(300,
          //       duration: const Duration(milliseconds: 100),
          //       curve: Curves.easeInOut);
          // }
        });
        position.animateTo(280,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
    );
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
          controller: scrollController,
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              expandedHeight: 350,

              pinned: true,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              collapsedHeight: 70,
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
                            color: Color.fromARGB(210, 0, 0, 0),
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
                            color: Color.fromARGB(210, 0, 0, 0),
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
              title: const Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Text("Farmace",
                            style: TextStyle(
                              color: Color.fromARGB(210, 0, 0, 0),
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left)),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 40,
                        ),
                      ),
                    )
                  ]),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: Colors.white,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PharmacyTile(width: width),
                    const PharmacyTile(),
                    const PharmacyTile(),
                    const PharmacyTile(),
                    const PharmacyTile(),
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                height: 1000,
              ),
              Container(
                color: Colors.red,
                height: 1000,
              ),
            ]))
          ]),
    );
  }
}
