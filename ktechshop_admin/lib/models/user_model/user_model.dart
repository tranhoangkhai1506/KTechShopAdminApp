import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String? notificationToken;
  String? image;
  String name;
  String email;

  UserModel({
    required this.id,
    this.notificationToken,
    this.image,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        notificationToken: json["notificationToken"]??"",
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "notificationToken": notificationToken,
      };

  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(
        image: image ?? this.image,
        name: name ?? this.name,
        id: id,
        email: email,
      );
}
