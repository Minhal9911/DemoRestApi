import 'dart:convert';

UserRequest userReqFromJson(String str) => UserRequest.fromJson(json.decode(str));

String userReqToJson(UserRequest data) => json.encode(data.toJson());

class UserRequest {
  UserRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.url,
  });

  String name;
  String email;
  String password;
  int age;
  String url;

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        age: json["age"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "age": age,
        "url": url,
      };
}
