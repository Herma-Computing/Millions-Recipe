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

  static String? getToken() => prefs.getString("token");

  static setProfilePicture(String imgUrl) => prefs.setString("image", imgUrl);

  static String? getProfilePicture() => prefs.getString("image");

  static setuserProfile(String birthdate, String occupation, String gender,
      String fName, String lName) async {
    prefs.setString("birthdate", birthdate);
    prefs.setString("occupation", occupation);
    prefs.setString("name", fName);
    prefs.setString("last_name", lName);
    // prefs.setString("email", email);
    prefs.setString("gender", gender);
  }

  static List getuserProfile() {
    return [
      prefs.getString("name"),
      prefs.getString("last_name"),
      prefs.getString("email"),
      prefs.getString("gender"),
      prefs.getString("birthdate"),
      prefs.getString("occupation"),
    ];
  }

  static String? getoccupation() => prefs.getString("occupation");

  // static Future<Profile> getUserProfile() async {

  //   String? birthdate = prefs.getString("birthdate");
  //   String? occupation = prefs.getString("occupation");
  //   String? country = prefs.getString("country");
  //   return Profile(occupation: occupation, birthdate: birthdate, country: country);
  // }
}
