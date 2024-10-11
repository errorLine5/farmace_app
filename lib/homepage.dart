import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          floating: true,
          snap: true,
          title: Flex(
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
        SliverFillRemaining(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text("In evidenza",
                    style: TextStyle(
                      color: Color.fromARGB(210, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.left),
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    semanticChildCount: 3,
                    children: [
                      Container(
                        width: 300,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 300,
                        color: Colors.amber,
                      ),
                      Container(
                        width: 300,
                        color: Colors.green,
                      )
                    ]),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
