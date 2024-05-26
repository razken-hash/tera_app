import 'dart:convert';
import 'dart:developer';

import 'package:tera_app/utils/constants.dart';
import 'package:http/http.dart';

class DocumentsService {
  static final Client client = Client();

  static Future<String> createDocument(String token) async {
    try {
      final response = await client.post(
        Uri.parse("$BASE_URL/docs/create"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
        body: jsonEncode({
          "createdAt": DateTime.now().millisecondsSinceEpoch,
        }),
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

  static Future<List<String>> getAllDocuments({required String token}) async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL/docs/me"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
      );

      log(response.body);

      switch (response.statusCode) {
        case 200:
          final result = jsonDecode(response.body);
          int i = 0;
          while (i < result.length) {
            result[i] = jsonDecode(result[i]);
            i++;
          }
          return result;
        default:
          break;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  static Future<String> getDocumentById(
      {required String token, required String id}) async {
    try {
      final response = await client.get(
        Uri.parse("$BASE_URL/docs/$id"),
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

  static Future<String> updateDocumentTitle(
      {required String token,
      required String id,
      required String title}) async {
    try {
      final response = await client.post(
        Uri.parse("$BASE_URL/docs/title"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
        body: jsonEncode(
          {
            "id": id,
            "title": title,
          },
        ),
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
