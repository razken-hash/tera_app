// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/services/local_storage_service.dart';
import 'package:tera_app/utils/constants.dart';

class GoogleSignInRepository {
  late GoogleSignIn _googleSignIn;
  late Client _client;

  GoogleSignInRepository(
      {required GoogleSignIn googleSignIn,
      required Client client,}) {
    _googleSignIn = googleSignIn;
    _client = client;
  }

  Future<User?> signInWithGoogle() async {
    try {
      log(BASE_URL);
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        User user = User(
          email: googleSignInAccount.email,
          name: googleSignInAccount.displayName ?? "",
          picture: googleSignInAccount.photoUrl ?? "",
          id: "",
          token: "",
        );

        final response = await _client.post(
          Uri.parse("$BASE_URL/auth"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: user.toJson(),
        );

        log(response.body);

        switch (response.statusCode) {
          case 200:
            final responseBody = jsonDecode(response.body);
            user = user.copyWith(
              id: responseBody["user"]["_id"],
              token: responseBody["token"],
            );
            return user;
          default:
            break;
        }
      }
    } catch (e) {}
    return null;
  }

  Future<bool> signOutWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signOut();
      if (googleSignInAccount == null) {
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<User?> getUserData() async {
    try {
      final String? token = await LocalStorageService.getAuthToken();

      if (token == null) return null;

      final response = await _client.get(
        Uri.parse("$BASE_URL/user"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
      );

      log(response.body);

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          User user = User.fromJson(jsonEncode(responseBody["user"])).copyWith(
            token: responseBody["token"],
          );
          return user;
        default:
          break;
      }
    } catch (e) {}
    return null;
  }
}
