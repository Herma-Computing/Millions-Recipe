import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'constants.dart';

class ApiProvider {
  Future<String> registerUser(String email, String firstname, String lastname,
      String password, String registerWith) async {
    String res = "Some error is occured";
    http.Response? response;

    try {
      String passwordParam = "password";
      String firstNameParam = "first_name";
      String lastNameParam = "last_name";
      if (registerWith == "google") {
        passwordParam = "google_user_id";
        firstNameParam = "given_name";
        lastNameParam = "family_name";
      }
      response = await http.post(Uri.parse(AppUrl.userregisterUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "registed_with": registerWith,
            "email": email,
            firstNameParam: firstname,
            lastNameParam: lastname,
            passwordParam: password
          }));

      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception {
      //res = "Some error is occured";
    }
    //
    return res;
  }

  Future<String> loginUser(
      String email, String password, String loginWith) async {
    String res = "Some error is occured";
    try {
      var dio = Dio();
      Response response = await dio.post(
        AppUrl.loginUrl,
        data: jsonEncode(<String, dynamic>{
          'username': email,
          'password': password,
          'login_with': loginWith,
        }),
      );

      if (response.statusCode == 200) {
        res = "success";
      } else {
        String? message = response.statusMessage;
        res = message!;
      }
    } on Exception {
      res = "Some error is occured";
    }
    return res;
  }

  Future<String> verification(String email, int otp) async {
    String res = "Some error is occured";
    http.Response? response;
    try {
      response = await http.post(Uri.parse(AppUrl.activateaccount),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"email": email, "code": otp}));
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.body.toString());
        String message = temp['message'];
        res = message;
      }
    } on Exception {
      res = "Some error is occured";
    }

    return res;
  }
}
