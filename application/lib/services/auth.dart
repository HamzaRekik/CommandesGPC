import 'package:application/user.dart';
import 'package:dio/dio.dart' as diohttp;
import 'package:flutter/material.dart';
import 'package:application/services/dio.dart';

class Auth extends ChangeNotifier {
  User? _user;
  bool _isLoggedIn = false;
  bool get authenticated => _isLoggedIn;
  User? get user => _user;
  void login({Map? creds}) async {
    print(creds);
    try {
      diohttp.Response response = await dio()!.post("/login", data: creds);
      if (response.statusCode == 200) {
        _isLoggedIn = true;
        print(_isLoggedIn);
        print(response.data['token'].toString());
        // String token = response.data['token'].toString();
        // tryToken(token: token);
      } else {
        print("wrong email or password");
      }

      notifyListeners();
    } catch (e) {
      print("Error");
    }
  }

  // void tryToken({String? token}) async {
  //   if (token == null) {
  //     return;
  //   } else {
  //     try {
  //       diohttp.Response response = await dio()!.post("/user",
  //           options:
  //               diohttp.Options(headers: {'Authorization': 'Bearer $token'}));
  //       _isLoggedIn = true;
  //       _user = User.fromJson(response.data);
  //       notifyListeners();
  //       print(_user);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
