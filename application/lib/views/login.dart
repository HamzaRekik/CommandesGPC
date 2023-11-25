import 'package:application/services/AuthService.dart';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'order_form.dart';

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
                      ElevatedButton(
                          child: Text('Se Connecter',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            AuthenticationService().login(
                                emailAddress: _emailController.text,
                                password: _passwordController.text,
                                context: context);
                          }),
                    ],
                  ),
                )),
          ),
        ));
  }
}
