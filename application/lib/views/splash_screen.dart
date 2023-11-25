import 'package:flutter/material.dart';

import '../services/AuthService.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  Future<void> _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 6));
    Navigator.pushReplacementNamed(context,
        AuthenticationService().userStatus() ? '/orders_list' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('images/gpc.png')),
    );
  }
}
