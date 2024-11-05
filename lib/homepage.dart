// ignore_for_file: avoid_print, duplicate_ignore, non_constant_identifier_names

import 'dart:convert';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:farmace_app/create_pharmacy.dart';
import 'package:farmace_app/homepageComponents/pharmacy_list_element.dart';
import 'package:farmace_app/homepageComponents/pharmacy_tile.dart';
import 'package:farmace_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:farmace_app/conndata.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  void Function() toggleTheme = () {};
  Homepage({required this.toggleTheme, super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double width = 0;
  SharedPreferences? prefs = null;
  Future<dynamic> CarouselData = Future.value({});
  Future<dynamic> ListNearbyData = Future.value({});
  Future<dynamic> UserData = Future.value({});
  String email = "placeholdermail.@gmail.com";
  String username = "User Name";
  String profilePicture = "https://picsum.photos/800/900";
  bool canOwn = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        print("value: $value");
        prefs = value;

        CarouselData = getPharmacies(30, 160, 10000);

        ListNearbyData = getPharmacies(30, 160, 10000);
        print("email: ${prefs!.getString("email")}");
        print("token: ${prefs!.getString("token")}");
        UserData = getUserData(
            email: prefs!.getString("email")!,
            token: prefs!.getString("token")!,
            password: "");

        UserData.then((value) {
          setState(() {
            print("value: $value");
            if (value != null) {
              username = value[1];
              profilePicture = value[7];
              email = value[2];
              print("canOwn: ${value[8]}");
              canOwn = (value[8] == 1) ? true : false;
              print("canOwn: $canOwn");
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController(
      initialScrollOffset: 280,
      onAttach: (position) {
        position.addListener(() {
          // ignore: duplicate_ignore
          // ignore: avoid_print

          if (position.userScrollDirection == ScrollDirection.reverse) {
            if (position.pixels > 100 && position.pixels < 280) {
              position.animateTo(280,
                  duration: const Duration(milliseconds: 50),
                  curve: Curves.easeInOut);
            }
          }
          if (position.userScrollDirection == ScrollDirection.forward) {
            if (position.pixels > 290 && position.pixels < 600) {
              position.animateTo(290,
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

        position.animateTo(279,
            duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
      },
    );
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BlurryContainer(
          borderRadius: BorderRadius.circular(0),
          color: Theme.of(context).appBarTheme.backgroundColor!.withAlpha(204),
          blur: 10,
          height: 70,
          width: 250,
          child: Flex(direction: Axis.horizontal, children: [
            const Spacer(
              flex: 1,
            ),
            IconButton(
                enableFeedback: canOwn,
                onPressed: canOwn
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CreatePharmacy()));
                      }
                    : null,
                icon: const Icon(
                  Icons.local_pharmacy,
                )),
            const Spacer(flex: 2),
            const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.search,
                )),
            const Spacer(flex: 2),
            const Icon(
              Icons.person,
            ),
            const Spacer(flex: 2),
            IconButton(
              onPressed: () {
                //show a dialog with a logout button and a cancel button
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text("Do you want to logout?")),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error))),
                            TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .error
                                        .withRed(150)),
                                onPressed: () {
                                  prefs!.clear();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => const MyApp()));
                                },
                                child: const Text("Logout", style: TextStyle()))
                          ],
                        ));
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ])),
      body: RefreshIndicator(
        color: Theme.of(context).textTheme.titleLarge?.color,
        onRefresh: () async {
          setState(() {
            CarouselData = getOpenPharmacies(1, 1, 1000);
            ListNearbyData = getOpenPharmacies(1, 1, 1000);
          });
        },
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              expandedHeight: 350,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              pinned: true,
              collapsedHeight: 70,
              elevation: 1,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: prefs != null
                      ? Flex(
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
                                    profilePicture,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                const Spacer(),
                                Text(
                                  username,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "OpenSans",
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const Spacer(),
                              ],
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                const Spacer(),
                                Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "OpenSans",
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const Spacer(),
                              ],
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator())),
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
                        padding: const EdgeInsets.only(right: 20.0),
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
                padding: EdgeInsets.only(left: 10, top: 16, right: 14),
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
              SizedBox(
                  height: 200,
                  child: FutureBuilder(
                      future: CarouselData,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              for (int i = 0; i < snapshot.data!.length; i++)
                                PharmacyTile(
                                  width: 380,
                                  data: snapshot.data![i],
                                )
                            ],
                          );
                        }
                      })),
            ])),
            const SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 8, top: 10, right: 14, bottom: 0.0),
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
            SliverToBoxAdapter(
                child: FutureBuilder(
              future: ListNearbyData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (int i = 0; i < snapshot.data!.length + 3; i++)
                        (i < snapshot.data!.length
                            ? PharmacyListElement(data: snapshot.data![i])
                            : Container(height: 170))
                    ],
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<dynamic> getOpenPharmacies(double lat, double lon, double range) {
    List<String> days = [
      "lunedì",
      "martedì",
      "mercoledì",
      "giovedì",
      "venerdì",
      "sabato",
      "domenica"
    ];

    var userCoord = {"latitude": lat, "longitude": lon, "range": range};

    var todayHour = DateTime.now().hour;
    var todayDay = DateTime.now().weekday;
    var orarioRicerca = {
      "giorno": days[todayDay - 1],
      "orario_corrente": "$todayHour:00"
    };

    var requestTemplate = {
      "userCoord": userCoord,
      "orarioRicerca": orarioRicerca
    };

    //request data from api
    var response = http
        .post(Uri.parse("${Connection().url}/pharmacy/ricerca_range_orari"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(requestTemplate))
        .then((value) {
      if (value.statusCode == 200) {
        return jsonDecode(value.body);
      }
    });

    return response;
  }

  Future<dynamic> getPharmacies(double lat, double lon, double range) {
    var requestTemplate = {"latitude": lat, "longitude": lon, "range": range};

    //request data from api
    var response = http
        .post(Uri.parse("${Connection().url}/pharmacy/ricerca"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(requestTemplate))
        .then((value) {
      if (value.statusCode == 200) {
        return jsonDecode(value.body);
      }
    });

    return response;
  }

  Future<dynamic> getUserData(
      {required String email,
      required String password,
      required String token}) async {
    var requestTemplate = {
      "token": token,
      "email": email,
      "password": password
    };

    var response = http
        .post(Uri.parse("${Connection().url}/auth/getMe"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(requestTemplate))
        .then((value) {
      if (value.statusCode == 200) {
        print("userdata:${value.body}");
        return jsonDecode(value.body);
      }
    });
    return response;
  }
}
