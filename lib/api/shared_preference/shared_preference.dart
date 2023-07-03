import 'package:millions_recipe/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late final SharedPreferences prefs;

  static Future init() async => prefs = await SharedPreferences.getInstance();
// set AuthToken once user login completed
  static Future<bool> setuser(
    String image,
    String username,
    String firstName,
    String lastName,
    String email,
    String token,
  ) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs = await SharedPreferences.getInstance();
    prefs.setString("image", image);
    prefs.setString("username", username);
    prefs.setString("name", firstName);
    prefs.setString("last_name", lastName);

    prefs.setString("email", email);

    prefs.setString("token", token);

    return true;
  }

  static String? getName() => prefs.getString("name");

  static Future<User> getuser(String image, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("name");
    // Image? image = prefs.getString("image");
    return User(name: name, image: image);
  }
}
