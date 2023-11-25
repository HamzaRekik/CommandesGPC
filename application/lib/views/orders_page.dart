import 'package:application/services/AuthService.dart';
import 'package:flutter/material.dart';

import '../widgets/orders_builder.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          title: Text('Liste Des Commandes'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AuthenticationService().logout();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          },
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.logout),
        ),
        backgroundColor: Colors.grey[200],
        body: const CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            OrdersBuilder(),
          ],
        ));
  }
}
