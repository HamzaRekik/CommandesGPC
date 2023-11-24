import 'package:application/views/orders_page.dart';
import 'package:application/views/login.dart';
import 'package:application/views/order_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GPC());
}

class GPC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/commandes_list': (context) => OrdersPage(),
        '/make_order': (context) => Order()
      },
    );
  }
}
