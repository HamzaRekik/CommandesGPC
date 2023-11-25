import 'package:application/services/AuthService.dart';
import 'package:application/views/orders_page.dart';
import 'package:application/views/login.dart';
import 'package:application/views/order_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GPC());
}

class GPC extends StatefulWidget {
  @override
  State<GPC> createState() => _GPCState();
}

class _GPCState extends State<GPC> {
  @override
  void initState() {
    AuthenticationService().checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          AuthenticationService().userStatus() ? '/orders_list' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/orders_list': (context) => OrdersPage(),
        '/make_order': (context) => Order()
      },
    );
  }
}
