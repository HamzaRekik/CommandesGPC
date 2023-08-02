import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Welcome , "), actions: [
          IconButton(
            icon: Icon(Icons.logout_sharp),
            onPressed: () {},
          ),
        ]),
        body: Container(
          child: Text("hamza"),
        ));
  }
}
