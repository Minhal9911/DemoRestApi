import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/all_user_res.dart';
import '../model/user_req_id.dart';
import '../model/user_res.dart';

class ApiServices {
  static const getAllUserUrl = '/user/all';
  static const getUserByIdUrl = '/user/';
  static const addUserUrl = '/user/add';
  static const updateUserUrl = '/user/';
  static const deleteUserUrl = '/user/';

  final dio = Dio(BaseOptions(baseUrl: 'http://3.109.153.198:8080'));

  Future<List<UserRes>> getAllUser() async {
    try {
      var response = await dio.get(getAllUserUrl);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        debugPrint('getting data');
        List<UserRes> users = userResFromJson(response.data.toString());
        return users;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('error: ${e.toString()}');
      return [];
    }
  }

  Future<UserReqIdModel?> getUserById(String id) async {
    try {
      var response = await dio.get('$getUserByIdUrl$id');
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        debugPrint('getting data by id');
        UserReqIdModel getData =
            userReqIdModelFromJson(response.data.toString());
        return getData;
      }
    } catch (e) {
      debugPrint('error:${e.toString()}');
    }
    return null;
  }

  Future<void> addUser(Map<String, dynamic> data) async {
    try {
      var response = await dio.post(addUserUrl, data: data);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        debugPrint('adding data');
      }
    } catch (e) {
      debugPrint('error:${e.toString()}');
    }
  }

  Future<UserRes?> updateUser(Map<String, dynamic> data, String id) async {
    try {
      var response = await dio.put('$updateUserUrl$id', data: data);
      debugPrint('updating data');
      if (response.statusCode == 200) {
        debugPrint('Edit success');
      }
    } catch (e) {
      debugPrint('error:${e.toString()}');
    }
    return null;
  }

  Future<bool> deleteUser(String id) async {
    bool status = false;
    try {
      var response = await dio.delete('$deleteUserUrl$id');
      debugPrint('deleting process');
      if (response.statusCode == 200) {
        debugPrint('delete');
        status = true;
      }
      return status;
    } catch (e) {
      debugPrint(e.toString());
      return status;
    }
  }
}
