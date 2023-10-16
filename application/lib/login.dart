import 'dart:async';

import 'package:application/commandes_list.dart';
import 'package:application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application/services/auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Order()),
            );
          },
          child: Icon(Icons.shopping_cart),
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
                margin: EdgeInsets.only(top: 125),
                color: const Color.fromRGBO(229, 229, 235, 255),
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset("images/3.png"),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        validator: (value) => value!.isEmpty
                            ? 'please enter an valid email'
                            : null,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'please enter password' : null,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blueAccent,
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 24.0),
                      RoundedLoadingButton(
                          color: Colors.blueAccent,
                          failedIcon: Icons.error,
                          child: Text('Se Connecter',
                              style: TextStyle(color: Colors.white)),
                          controller: _btnController,
                          resetDuration: Duration(seconds: 4),
                          resetAfterDuration: true,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await Timer(Duration(seconds: 2), () {
                              if (_emailController.text ==
                                      "hamzarekik@gmail.com" &&
                                  _passwordController.text == "hamza") {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommandesList()),
                                );
                                _emailController.clear();
                                _passwordController.clear();
                              } else {
                                _btnController.error();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Email ou Mot de passe sont incorrectes'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                _btnController.reset();
                                _emailController.clear();
                                _passwordController.clear();
                              }
                            });
                          }),
                    ],
                  ),
                )),
          ),
        ));
  }
}
