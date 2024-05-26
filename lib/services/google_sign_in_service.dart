import 'dart:convert';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/utils/constants.dart';

class GoogleSignInService {
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static Client client = Client();

  static Future<String> signInWithGoogle() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        User user = User(
          email: googleSignInAccount.email,
          name: googleSignInAccount.displayName ?? "",
          picture: googleSignInAccount.photoUrl ?? "",
          id: "",
          token: "",
        );

        final response = await client.post(
          Uri.parse("$BASE_URL/auth"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: user.toJson(),
        );

        log(response.body);

        switch (response.statusCode) {
          case 200:
            return response.body;
          default:
            break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return "";
  }

  static Future<GoogleSignInAccount?> signOutWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount;
    try {
      googleSignInAccount = await googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }
    return googleSignInAccount;
  }

  static Future<String> getUserData({required String token}) async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL/user"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
      );

      log(response.body);

      switch (response.statusCode) {
        case 200:
          return response.body;
        default:
          break;
      }
    } catch (e) {
      log(e.toString());
    }
    return "";
  }
}
