import 'dart:convert';
import 'package:flutter/foundation.dart';

class Document {
  final String uid;
  final String id;
  final String title;
  final List content;
  final DateTime createdAt;
  Document({
    required this.uid,
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Document copyWith({
    String? uid,
    String? id,
    String? title,
    List? content,
    DateTime? createdAt,
  }) {
    return Document(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      '_id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      uid: map['uid'] as String,
      id: map['_id'] as String,
      title: map['title'] as String,
      content: List.from((map['content'] as List)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Document(uid: $uid, id: $id, title: $title, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Document other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.id == id &&
        other.title == title &&
        listEquals(other.content, content) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        createdAt.hashCode;
  }
}
