import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  AuthenticationService();

  checkUserStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('----------------------------User is currently signed out!');
      } else {
        print('----------------------------User is signed in!');
      }
    });
  }

  login({required emailAddress, required password, context}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Navigator.pushNamedAndRemoveUntil(
          context, '/orders_list', (route) => false);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text(
            'Invalid login credentials. Please check your email and password.',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  userStatus() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null)
      return false;
    else
      return true;
  }
}
