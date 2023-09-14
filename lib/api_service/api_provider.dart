import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/shared_preference/shared_preference.dart';
import '../models/auth_model.dart';
import 'constants.dart';

class ApiProvider {
  Future<String> registerUser(String email, String firstname, String lastname,
      String password, String registerWith) async {
    String res = "Some error occurred";
    Dio dio = Dio();

    try {
      String passwordParam = "password";
      String firstNameParam = "first_name";
      String lastNameParam = "last_name";

      if (registerWith == "google") {
        passwordParam = "google_user_id";
        firstNameParam = "given_name";
        lastNameParam = "family_name";
      }

      var response = await dio.post(
        AppUrl.userregisterUrl,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
        data: {
          "registed_with": registerWith,
          "email": email,
          firstNameParam: firstname,
          lastNameParam: lastname,
          passwordParam: password,
        },
      );

      if (response.statusCode == 200) {
        res = "success";

        if (registerWith == "google") {
          var userInfo = response.data;
          String? image =
              "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50";
          if (userInfo['image'] != null) {
            image = userInfo['image'];
          }
          UserPreferences.setuser(
              image!,
              userInfo['username']!,
              userInfo['first_name'],
              userInfo['last_name'],
              email.toString(),
              userInfo['token']);
        }
      } else {
        var temp = response.data;
        String message = temp['message'];
        res = message;
      }
    } on DioError catch (e) {
      Response response = e.response!;
      res = response.data['message'];
    } on Exception {
      res = "Some error is occured";
    }
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
        final responseBody = response.data;
        final AuthModel authModel = authModelFromJson(responseBody);

        UserPreferences.setuser(
          authModel.userImage.toString(),
          authModel.username.toString(),
          authModel.userFirstName.toString(),
          authModel.userLastName.toString(),
          authModel.userEmail.toString(),
          authModel.token.toString(),
        );
      } else {
        String? message = response.statusMessage;
        res = message!;
      }
    } on DioError catch (e) {
      Response response = e.response!;
      res = response.data['message'];
    } on Exception {
      res = "Some error is occured";
    }
    return res;
  }

  Future<String> verification(String email, int otp) async {
    String res = "Some error occurred";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        AppUrl.activateaccount,
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: jsonEncode(<String, dynamic>{"email": email, "code": otp}),
      );
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.data.toString());
        String message = temp['message'];
        res = message;
      }
    } on DioError catch (e) {
      Response response = e.response!;
      res = response.data['message'];
    } on Exception {
      res = "Some error is occured";
    }

    return res;
  }

  Future<String> resendActivation(String email) async {
    String res = "Some error occurred";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        AppUrl.resendActivation,
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: jsonEncode(<String, dynamic>{"email": email}),
      );
      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = jsonDecode(response.data.toString());
        String message = temp['message'];
        res = message;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var temp = jsonDecode(e.response!.data.toString());
        String message = temp['message'];
        res = message;
      } else {
        res = e.toString();
        // res = "Some error occurred";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> sendInstruction(String email) async {
    String res = "Some error occurred";
    Dio dio = Dio();

    try {
      var response = await dio.post(
        AppUrl.sendInstraction,
        data: {"user_login": email},
        options: Options(
          contentType: 'application/json; charset=UTF-8',
        ),
      );

      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = response.data;
        String message = temp['message'];
        res = message;
      }
    } on DioError catch (e) {
      Response response = e.response!;
      res = response.data['message'];
    } on Exception {
      res = "Some error is occured";
    }

    return res;
  }

  Future<String> setNewPassword(String email, String newPass, int code) async {
    String res = "Some error occurred";
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        AppUrl.setnewpassword,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          "email": email,
          "password": newPass,
          "code": code,
        },
      );

      if (response.statusCode == 200) {
        res = "success";
      } else {
        var temp = response.data;
        String message = temp['message'];
        res = message;
      }
    } on DioError catch (e) {
      Response response = e.response!;
      res = response.data['message'];
    } on Exception {
      res = "Some error is occured";
    }

    return res;
  }

  Future<String> changeProfilePicture(String filePath, String? token) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });
    try {
      Response response = await dio
          .post(
        AppUrl.changeProfilePicture,
        data: formData,
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException("Connection timed out");
        },
      );
      if (response.statusCode == 200) {
        // parse the response data and return the image path
        //
        String imageUrl = response.data['message'];
        UserPreferences.setProfilePicture(imageUrl);
        return imageUrl;
      } else {
        throw Exception(
            "server returned non-200 response while uploading profile image");
      }
    } catch (error) {
      // we want to catch the error on the settings page code and display a snackbar to the user
      // so we are re-throwing the exception here.
      rethrow;
    }
  }

  Future<String> profilePatch(String fName, String? lName, String? birthdate,
      String? occupation, String? gender, String token) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.patch(
      AppUrl.profile,
      data: jsonEncode(<String, dynamic>{
        "first_name": fName,
        "last_name": lName,
        "occupation": occupation,
        "birthdate": birthdate,
        "country": gender,
      }),
    );
    if (response.statusCode == 200) {
      UserPreferences.setuserProfile(
          birthdate!, occupation!, gender!, fName, lName!);
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to update profile');
    }
  }
}
