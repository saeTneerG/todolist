import 'package:shared_preferences/shared_preferences.dart';

class User {
  String username;
  String email;

  static Future<bool?> getSignIn () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("signIn");
  }

  static Future setSignIn (bool signIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("signIn", signIn);
  }

  static Future<User?> getUser () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? username = pref.getString("username");
    String? email = pref.getString("email");
    if (username != null && email != null) {
      return User(username, email);
    }
    return null;
  }

  static Future saveUser (String username, String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("username", username);
    await pref.setString("email", email);
  }

  static Future clearUser () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("username");
    await pref.remove("email");
  }

  User(this.username, this.email);
}