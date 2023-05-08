import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/shared_preference/shared_preference.dart';
import '../models/auth_model.dart';
import 'constants.dart';

class ApiProvider {

  Future<String> registerUser(String email, String firstname, String lastname, String password, String registerWith) async {
    String res = "Some error is occured";

    try {
      String passwordParam = "password";
      String firstNameParam = "first_name";
      String lastNameParam = "last_name";
      if (registerWith == "google") {
        passwordParam = "google_user_id";
        firstNameParam = "given_name";
        lastNameParam = "family_name";
      }
      var dio = Dio();
      Map<String, dynamic> requestBody = {
        "registed_with": registerWith,
        "email": email,
        firstNameParam: firstname,
        lastNameParam: lastname,
        passwordParam: password
      };
      Response response = await dio.post(
        AppUrl.userregisterUrl,
        data: requestBody,
      );
      if (response.statusCode == 200) {
        res = "success";

        if (registerWith == "google") {
          var userInfo = jsonDecode(response.data.toString());
          String? image = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50";
          if (userInfo['image'] != null) {
            image = userInfo['image'];
          }
          UserPreferences.setuser(image!, userInfo['username']!, userInfo['first_name'], userInfo['last_name'], email.toString());
        }
      } else {}
    } catch (e) {
      if (e is DioError) {
        Response response = e.response!;
        res = response.data['message'];
      }
    }

    return res;
  }

  Future<String> verification(String email, int otp) async {
    String res = "Some error is occured";
    try {
      var dio = Dio();
      Map<String, dynamic> requestBody = {"email": email, "code": otp};
      Response response = await dio.post(
        AppUrl.activateaccount,
        data: requestBody,
      );
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.data.toString());
        String message = temp['message'];
        res = message;
      }
    } catch (_) {
      res = "Some error is occured";
    }

    return res;
  }

  Future<String> loginUser(String email, String password, String loginWith) async {
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
        final responseBody = response.data;
        final AuthModel authModel = authModelFromJson(responseBody);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("token", authModel.token);

        UserPreferences.setuser(
          authModel.userImage.toString(),
          authModel.username.toString(),
          authModel.userFirstName.toString(),
          authModel.userLastName.toString(),
          authModel.userEmail.toString(),
        );
      }
    } catch (e) {
      if (e is DioError) {
        Response response = e.response!;
        res = response.data['message'];
      } else {
        res = "Some error is occured";
      }
    }
    return res;
  }

}
