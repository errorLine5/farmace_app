// ignore_for_file: avoid_print, duplicate_ignore, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';

import 'package:farmace_app/Register.dart';
import 'package:farmace_app/conndata.dart';
import 'package:farmace_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  void Function() toggleTheme = () {};
  Login({required this.toggleTheme, super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        prefs = value;
        print("init state");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: null,
        actions: null,
        elevation: 0,
        primary: true,
        backgroundColor: Colors.transparent,
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
              tileMode: TileMode.clamp,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.transparent,
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
                                onPressed: () => {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register(
                                                toggleTheme:
                                                    widget.toggleTheme)),
                                      )
                                    },
                                style: const ButtonStyle(
                                  minimumSize:
                                      WidgetStatePropertyAll(Size(150, 50)),
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                ),
                                child: const Text("Register",
                                    style: TextStyle(fontSize: 15))),
                            TextButton(
                                // ignore: avoid_print
                                onPressed: () => print("Forgot Password"),
                                style: const ButtonStyle(
                                  minimumSize:
                                      WidgetStatePropertyAll(Size(180, 50)),
                                  foregroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                ),
                                child: const Text("Forgot Password",
                                    style: TextStyle(fontSize: 15)))
                          ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      TextButton(
                          onPressed: () async {
                            var headers = {'Content-Type': 'application/json'};

                            http
                                .post(
                                    headers: headers,
                                    Uri.parse("${Connection().url}/auth/login"),
                                    body: jsonEncode({
                                      "email": email,
                                      "password": password,
                                      "token": ""
                                    }))
                                .then((value) {
                              if (value.statusCode == 200) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Login successful"),
                                ));
                                prefs.setString(
                                    'token', jsonDecode(value.body)['token']);
                                prefs.setString('email', email);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage(
                                          toggleTheme: widget.toggleTheme)),
                                );

                                print(value.body);
                              } else {
                                //toast error
                                print(value.body);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Incorrect email or password"),
                                ));
                              }
                            });
                          },
                          style: const ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(Size(200, 50)),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          child: const Text("Login",
                              style: TextStyle(fontSize: 15))),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.5)),
                      TextFormField(
                          onChanged: (value) => password = value,
                          obscureText: true,
                          validator: (value) =>
                              value!.isNotEmpty ? null : 'Password is required',
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(59, 245, 245, 245),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.key, color: Colors.white),
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ))),
                      TextFormField(
                          onChanged: (value) => email = value,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(59, 245, 245, 245),
                              labelText: 'Email',
                              floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2),
                              ),
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
