import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tera_app/services/documents_service.dart';
import 'package:tera_app/services/local_storage_service.dart';

import '../models/document.dart';

class DocumentsProvider extends ChangeNotifier {
  Future<Document?> createDocument() async {
    final token = await LocalStorageService.getAuthToken();
    if (token == null) return null;
    final response = await DocumentsService.createDocument(token);
    Document document = Document.fromJson(response);
    return document;
  }

  Future<List<Document>> getAllDocuments() async {
    final token = await LocalStorageService.getAuthToken();
    if (token == null) return [];
    final response = await DocumentsService.getAllDocuments(token: token);
    List<Document> documents = [];
    for (var item in response) {
      documents.add(Document.fromJson(item));
    }
    return documents;
  }

  Future<Document?> getDocumentById({required String documentId}) async {
    final token = await LocalStorageService.getAuthToken();
    if (token == null) return null;
    final response =
        await DocumentsService.getDocumentById(token: token, id: documentId);
    Document document = Document.fromJson(response);
    return document;
  }

  Future<Document?> updateDocumentTitle(
      {required String documentId, required String title}) async {
    final token = await LocalStorageService.getAuthToken();
    if (token == null) return null;
    final response = await DocumentsService.updateDocumentTitle(
        token: token, id: documentId, title: title);
    Document document = Document.fromJson(response);
    return document;
  }
}
