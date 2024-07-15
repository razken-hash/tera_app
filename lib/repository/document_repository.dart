// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:tera_app/utils/constants.dart';
import 'package:http/http.dart';

import '../models/document.dart';

class DocumentRepository {
  late Client _client;

  DocumentRepository({
    required Client client,
  }) {
    _client = client;
  }

  Future<Document?> createDocument(String token) async {
    try {
      final response = await _client.post(
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
          Document document = Document.fromJson(response.body);
          return document;
        default:
          break;
      }
    } catch (e) {}
    return null;
  }

  Future<List<Document>> getDocuments(String token) async {
    List<Document> documents = [];
    try {
      final response = await _client.get(
        Uri.parse("$BASE_URL/docs/me"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
      );

      log(response.body);

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          for (var doc in responseBody) {
            Document document = Document.fromJson(jsonEncode(doc));
            documents.add(document);
          }
        default:
          break;
      }
    } catch (e) {}
    return documents;
  }

  Future<Document?> getDocumentById(String token, String id) async {
    try {
      final response = await _client.get(
        Uri.parse("$BASE_URL/docs/$id"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "token": token,
        },
      );

      log(response.body);

      switch (response.statusCode) {
        case 200:
          return Document.fromJson(response.body);
        default:
          break;
      }
    } catch (e) {}
    return null;
  }

  Future<List<Document>> updateDocumentTitle(
      {required String token,
      required String id,
      required String title}) async {
    List<Document> documents = [];
    try {
      final response = await _client.post(
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
          final responseBody = jsonDecode(response.body);
          for (var doc in responseBody) {
            Document document = Document.fromJson(jsonEncode(doc));
            documents.add(document);
          }
        default:
          break;
      }
    } catch (e) {}
    return documents;
  }
}
