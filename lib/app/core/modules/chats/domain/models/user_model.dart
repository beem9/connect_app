// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String id;
  final String? photo;
  final String? userLocation;
  final String username;
  UserModel({
    required this.email,
    required this.id,
    this.photo,
    this.userLocation,
    required this.username,
  });

  UserModel copyWith({
    String? email,
    String? id,
    String? photo,
    String? userLocation,
    String? username,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      photo: photo ?? this.photo,
      userLocation: userLocation ?? this.userLocation,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id': id,
      'photo': photo,
      'userLocation': userLocation,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        email: map['email'] as String,
        id: map['id'] as String,
        photo: map['photo'] ?? "",
        userLocation: map['userLocation'] ?? "",
        username: map['username'] as String,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, id: $id, photo: $photo, userLocation: $userLocation, username: $username)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.id == id &&
        other.photo == photo &&
        other.userLocation == userLocation &&
        other.username == username;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        id.hashCode ^
        photo.hashCode ^
        userLocation.hashCode ^
        username.hashCode;
  }
}
