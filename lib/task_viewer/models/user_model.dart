import 'package:shared_preferences/shared_preferences.dart';

class User {
  String userId;
  String username;
  String email;

  User(this.userId, this.username, this.email);

  static Future<bool?> getSignIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("signIn");
  }

  static Future setSignIn(bool signIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("signIn", signIn);
  }

  static Future<void> setUserData({
    required String username,
    required String email,
    required String userId,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userId", userId);
    await pref.setString("username", username);
    await pref.setString("email", email);
  }

  static Future<Map<String, String>?> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? username = pref.getString("username");
    String? email = pref.getString("email");
    String? userId = pref.getString("userId");
    if (username != null && email != null) {
      return {
        "username": username,
        "email": email,
        "userId": ?userId,
      };
    } else {
      return null;
    }
  }

  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("username");
    await pref.remove("email");
    await pref.remove("signIn");
    await pref.remove("userId");
  }
}
