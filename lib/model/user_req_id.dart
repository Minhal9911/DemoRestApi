import 'dart:convert';

UserReqIdModel userReqIdModelFromJson(String str) =>
    UserReqIdModel.fromJson(json.decode(str));

String userReqIdModelToJson(UserReqIdModel data) => json.encode(data.toJson());

class UserReqIdModel {
  UserReqIdModel({
    this.id,
    this.name,
    this.email,
    this.age,
    this.password,
    this.url,
    this.createDate,
    this.updateDate,
  });

  String? id;
  String? name;
  String? email;
  int? age;
  String? password;
  String? url;
  DateTime? createDate;
  dynamic updateDate;

  factory UserReqIdModel.fromJson(Map<String, dynamic> json) => UserReqIdModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        age: json["age"],
        password: json["password"],
        url: json["url"],
        createDate: json["createDate"] == null
            ? null
            : DateTime.parse(json["createDate"]),
        updateDate: json["updateDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "age": age,
        "password": password,
        "url": url,
        "createDate": createDate?.toIso8601String(),
        "updateDate": updateDate,
      };
}
