import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? about;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.about,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'about': about,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map["id"] ?? '' : null,
      name: map['name'] != null ? map["name"] ?? '' : null,
      email: map['email'] != null ? map["email"] ?? '' : null,
      profileImage:
          map['profileImage'] != null ? map["profileImage"] ?? '' : null,
      about: map['about'] != null ? map["about"] ?? '' : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
