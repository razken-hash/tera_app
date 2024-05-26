import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/services/google_sign_in_service.dart';
import 'package:tera_app/services/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  late final User user;

  Future<User?> signInWithGoogle() async {
    final response = await GoogleSignInService.signInWithGoogle();
    return User.fromMap(jsonDecode(response)["user"])
        .copyWith(token: jsonDecode(response)["token"]);
  }

  Future<bool> signOutWithGoogle() async {
    final googleSignInAccount = await GoogleSignInService.signOutWithGoogle();
    if (googleSignInAccount == null) {
      await LocalStorageService.clearLocalStorage();
      return true;
    }
    return false;
  }

  Future<User?> getUserData() async {
    final String? token = await LocalStorageService.getAuthToken();

    if (token == null) return null;

    final response = await GoogleSignInService.getUserData(token: token);

    User user =
        User.fromJson(jsonEncode(jsonDecode(response)["user"])).copyWith(
      token: jsonDecode(response)["token"],
    );
    return user;
  }
}
