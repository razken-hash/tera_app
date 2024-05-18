import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/utils/constants.dart';

Provider googleSignInRepositoryProvider = Provider(
  (ref) => GoogleSignInRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

StateProvider userProvider = StateProvider<User?>((ref) => null);

class GoogleSignInRepository {
  late GoogleSignIn _googleSignIn;
  late Client _client;

  GoogleSignInRepository(
      {required GoogleSignIn googleSignIn, required Client client}) {
    _googleSignIn = googleSignIn;
    _client = client;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        User user = User(
          email: googleSignInAccount.email,
          name: googleSignInAccount.displayName!,
          picture: googleSignInAccount.photoUrl!,
          id: "",
          token: "",
        );
        final response = await _client.post(
          Uri.parse("$BASE_URL/api/v1/auth/signin-with-google"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: user.toJson(),
        );

        switch (response.statusCode) {
          case 200:
            final responseBody = jsonDecode(response.body);
            return user.copyWith(
              id: responseBody["user"]["id"],
              token: responseBody["token"],
            );
          default:
            break;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
