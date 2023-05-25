import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/user_req_id.dart';
import '../model/user_res.dart';

class ApiServices {
  static const getAllUserUrl = '/user/all';
  static const getUserByIdUrl = '/user/';
  static const addUserUrl = '/user/add';
  static const updateUserUrl = '/user/';
  static const deleteUserUrl = '/user/';

  static final dio = Dio(BaseOptions(baseUrl: 'http://3.109.153.198:8080'));

  static Future<List<UserRes>> getAllUser() async {
    try {
      var response = await dio.get(getAllUserUrl);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        debugPrint('getting data');
        return (response.data as List).map((e) => UserRes.fromJson(e)).toList();
        /* List<UserRes> users =
            List<UserRes>.from(response.data.map((x) => UserRes.fromJson(x)));
        return users;*/
      } else {
        return [];
      }
    } on DioError catch (e) {
      debugPrint('error: ${e.toString()}');
      return [];
    }
  }

  static Future<UserReqIdModel?> getUserById(String id) async {
    try {
      var response = await dio.get('$getUserByIdUrl$id');
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        debugPrint('getting data by id');
        UserReqIdModel getData = UserReqIdModel.fromJson(response.data);
        // debugPrint('data got by id done');
        return getData;
      }
    } catch (e) {
      debugPrint('error:${e.toString()}');
    }
    return null;
  }

  static Future<void> addUser(Map<String, dynamic> data) async {
    try {
      var response = await dio.post(addUserUrl, data: data);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        debugPrint('adding data');
      }
    } on DioError catch (e) {
      debugPrint('error:${e.toString()}');
    }
  }

  static Future<UserRes?> updateUser(
      Map<String, dynamic> data, String id) async {
    try {
      var response = await dio.put('$updateUserUrl$id', data: data);
      debugPrint('updating data');
      if (response.statusCode == 200) {
        debugPrint('Edit success');
      }
    } on DioError catch (e) {
      debugPrint('error:${e.toString()}');
    }
    return null;
  }

  static Future<bool> deleteUser(String id) async {
    bool status = false;
    try {
      var response = await dio.delete('$deleteUserUrl$id');
      debugPrint('deleting process');
      if (response.statusCode == 200) {
        debugPrint('delete');
        status = true;
      }
      return status;
    } on DioError catch (e) {
      debugPrint(e.toString());
      return status;
    }
  }
}
