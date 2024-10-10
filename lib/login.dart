import 'dart:ui';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8,
              sigmaY: 8,
              tileMode: TileMode.mirror,
            ),
            child: Center(
              child: Container(
                height: double.infinity,
                width: 400,
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.up,
                  spacing: 10,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 0,
                        children: [
                          TextButton(
                              onPressed: () => print("Register"),
                              style: const ButtonStyle(
                                minimumSize:
                                    WidgetStatePropertyAll(Size(200, 50)),
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                              ),
                              child: const Text("Register",
                                  style: TextStyle(fontSize: 15))),
                          TextButton(
                              onPressed: () => print("Forgot Password"),
                              style: const ButtonStyle(
                                minimumSize:
                                    WidgetStatePropertyAll(Size(200, 50)),
                                foregroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                              ),
                              child: const Text("Forgot Password",
                                  style: TextStyle(fontSize: 15)))
                        ]),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    TextButton(
                        onPressed: () => print("Login"),
                        style: const ButtonStyle(
                          minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                          backgroundColor: WidgetStatePropertyAll(Colors.blue),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        child: const Text("Login",
                            style: TextStyle(fontSize: 15))),
                    Padding(padding: EdgeInsets.symmetric(vertical: 0.5)),
                    TextFormField(
                        obscureText: true,
                        validator: (value) =>
                            value!.isNotEmpty ? null : 'Password is required',
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(93, 141, 93, 93),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.key, color: Colors.white),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ))),
                    TextFormField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(93, 244, 68, 68),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
