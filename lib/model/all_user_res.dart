import 'dart:convert';

import 'package:mock_user_app/model/user_res.dart';

List<UserRes> userResFromJson(String str) => List<UserRes>.from(json.decode(str).map((x) => UserRes.fromJson(x)));

String userResToJson(List<UserRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


