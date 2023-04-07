import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mock_user_app/model/user_req_id.dart';

import '../model/all_user_res.dart';
import '../model/user_res.dart';

class Helper {
  static const baseUrl = '3.109.153.198:8080';
  static const getAllUserUrl = '/user/all';
  static const getUserByIdUrl = '/user/';
  static const addUserUrl = '/user/add';
  static const updateUserUrl = '/user/';
  static const deleteUserUrl = '/user/';

  static final client = http.Client();

  static Future<List<UserRes>> getAllUser() async {
    try {
      var response = await client.get(Uri.http(baseUrl, getAllUserUrl));
      if (response.statusCode == 200) {
        List<UserRes> users = userResFromJson(response.body);
        return users;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error ${e.toString()}');
      return [];
    }
  }

  static Future<UserReqIdModel?> getUserById(String id) async {
    try {
      var response = await client.get(Uri.http(baseUrl, '$getUserByIdUrl$id'));
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        UserReqIdModel getData =
            userReqIdModelFromJson(response.body.toString());
        return getData;
      }
    } catch (e) {
      debugPrint('Error ${e.toString()}');
    }
    return null;
  }

  static Future<void> addUser(Map<String, dynamic> data) async {
    try {
      var response = await client.post(Uri.http(baseUrl, addUserUrl),
          body: jsonEncode(data),
          headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        debugPrint('User successfully added');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<UserRes?> updateUser(
      Map<String, dynamic> data, String id) async {
    try {
      var response = await client.put(Uri.http(baseUrl, '$updateUserUrl$id'),
          body: jsonEncode(data),
          headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        debugPrint('Edit success');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<bool> deleteUser(String id) async {
    bool status = false;
    var response = await client.delete(Uri.http(baseUrl, '$deleteUserUrl$id'));
    // debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      debugPrint('deleted');
      status = true;
    }
    return status;
  }
}
