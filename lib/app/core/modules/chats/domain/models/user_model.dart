// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String userID;
  final double latitude;
  final double longitude;
  UserModel({
    required this.username,
    required this.email,
    required this.userID,
    required this.latitude,
    required this.longitude,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? userID,
    double? latitude,
    double? longitude,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      userID: userID ?? this.userID,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'userID': userID,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      userID: map['userID'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, userID: $userID, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.userID == userID &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        userID.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
