import 'package:application/user.dart';
import 'package:dio/dio.dart' as yolo;
import 'package:flutter/material.dart';
import 'package:application/services/dio.dart';

class Auth extends ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoggedIn = false;
  bool get authenticated => _isLoggedIn;
  User? get user => _user;
  void login({Map? creds}) async {
    print(creds);
    try {
      yolo.Response response = await dio()!.post("/login", data: creds);
      if (response.statusCode == 200) {
        _isLoggedIn = true;
        print(_isLoggedIn);
      }

      print(response.data['token'].toString());
      String token = response.data.toString();
      tryToken(token: token);

      notifyListeners();
    } catch (e) {
      print("Error");
    }
  }

  void tryToken({String? token}) async {
    if (token == null) {
      return;
    } else {
      try {
        yolo.Response response = await dio()!.post("/user",
            options: yolo.Options(headers: {'Authorization': 'Bearer $token'}));
        _isLoggedIn = true;
        _user = User.fromJson(response.data);
        notifyListeners();
        print(_user);
      } catch (e) {
        print(e);
      }
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
