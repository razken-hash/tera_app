import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tera_app/models/user.dart';
import 'package:tera_app/repository/local_storage_repository.dart';
import 'package:tera_app/utils/constants.dart';

Provider googleSignInRepositoryProvider = Provider(
  (ref) => GoogleSignInRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorageRepository: LocalStorageRepository(),
  ),
);

StateProvider userProvider = StateProvider<User?>((ref) => null);

class GoogleSignInRepository {
  late GoogleSignIn _googleSignIn;
  late Client _client;
  late LocalStorageRepository _localStorageRepository;

  GoogleSignInRepository(
      {required GoogleSignIn googleSignIn,
      required Client client,
      required LocalStorageRepository localStorageRepository}) {
    _googleSignIn = googleSignIn;
    _client = client;
    _localStorageRepository = localStorageRepository;
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
          Uri.parse("$BASE_URL/auth"),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: user.toJson(),
        );

        switch (response.statusCode) {
          case 200:
            final responseBody = jsonDecode(response.body);
            user = user.copyWith(
              id: responseBody["user"]["_id"],
              // token: responseBody["token"],
            );
            // _localStorageRepository.setAuthToken(user.token);
            return user;
          default:
            break;
        }
      }
    } catch (e) {}
    return null;
  }

  void signOutWithGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {}
    return null;
  }

  Future<User?> getUserData() async {
    try {
      final String? token = await _localStorageRepository.getAuthToken();
      if (token == null) return null;

      final response = await _client.get(
        Uri.parse("$BASE_URL/api/v1/auth/user"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token,
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          User user = User.fromJson(responseBody["body"]).copyWith(
            token: responseBody["token"],
          );
          return user;
        default:
          break;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
