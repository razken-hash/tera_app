import 'dart:convert';

class User {
  final String email;
  final String name;
  final String picture;
  final String id;
  final String token;

  User({
    required this.email,
    required this.name,
    required this.picture,
    required this.id,
    required this.token,
  });

  User copyWith({
    String? email,
    String? name,
    String? picture,
    String? id,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'picture': picture,
      '_id': id,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      name: map['name'] ?? "",
      picture: map['picture'] ?? "",
      id: map['_id'] ?? "",
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(email: $email, name: $name, picture: $picture, id: $id, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.picture == picture &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        picture.hashCode ^
        id.hashCode ^
        token.hashCode;
  }
}
