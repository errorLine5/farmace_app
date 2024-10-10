import 'dart:ui';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  TabController? tabController;
  List<Color> backAvailableColors = [
    Color.fromARGB(125, 255, 0, 0),
    Color.fromARGB(145, 0, 251, 255),
    Color.fromARGB(125, 10, 208, 135)
  ];
  Color? background_color;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    background_color = backAvailableColors[0];
    tabController!.addListener(() {
      setState(() {
        background_color = backAvailableColors[tabController!.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        title: const Text("Farmace",
            style: TextStyle(
              color: Color.fromARGB(211, 255, 255, 255),
              fontSize: 40,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              "https://picsum.photos/800/900",
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            color: background_color,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
                tileMode: TileMode.mirror,
              ),
              child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          spacing: 10,
                          children: [
                            TextFormField(
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(93, 244, 68, 68),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: 'Username',
                                    prefixIcon:
                                        Icon(Icons.person, color: Colors.white),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ))),
                            TextFormField(
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(93, 244, 68, 68),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: 'Email',
                                    prefixIcon:
                                        Icon(Icons.mail, color: Colors.white),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ))),
                            TextFormField(
                                obscureText: true,
                                validator: (value) => value!.isNotEmpty
                                    ? null
                                    : 'Password is required',
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(93, 141, 93, 93),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: 'Password',
                                    prefixIcon:
                                        Icon(Icons.key, color: Colors.white),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ))),
                            TextButton(
                                onPressed: () {
                                  tabController!
                                      .animateTo(tabController!.index + 1);
                                },
                                style: const ButtonStyle(
                                  minimumSize:
                                      WidgetStatePropertyAll(Size(200, 50)),
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                ),
                                child: Text("Next"))
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          spacing: 10,
                          children: [
                            TextFormField(
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(93, 244, 68, 68),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: 'Name',
                                    prefixIcon:
                                        Icon(Icons.person, color: Colors.white),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ))),
                            TextFormField(
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(93, 244, 68, 68),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: 'Lastname',
                                    prefixIcon:
                                        Icon(Icons.person, color: Colors.white),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ))),
                            TextFormField(
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(93, 141, 93, 93),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: 'PhoneNumber',
                                    prefixIcon:
                                        Icon(Icons.phone, color: Colors.white),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ))),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        tabController!.animateTo(
                                            tabController!.index - 1);
                                      },
                                      style: const ButtonStyle(
                                        minimumSize: WidgetStatePropertyAll(
                                            Size(200, 50)),
                                        foregroundColor: WidgetStatePropertyAll(
                                            Colors.white),
                                      ),
                                      child: Text("Back")),
                                  TextButton(
                                      onPressed: () {
                                        tabController!.animateTo(
                                            tabController!.index + 1);
                                      },
                                      style: const ButtonStyle(
                                        minimumSize: WidgetStatePropertyAll(
                                            Size(200, 50)),
                                        foregroundColor: WidgetStatePropertyAll(
                                            Colors.white),
                                      ),
                                      child: Text("Next"))
                                ])
                          ]),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Complete Registration"),
                      ),
                    ),
                  ])),
        ],
      ),
    );
  }
}