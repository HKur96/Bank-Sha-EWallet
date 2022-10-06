import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/model/auth_model/user_model.dart';
import '../../data/model/user_model/user_pin_edit_form_model.dart';
import '../../config/api.dart';
import '../../data/model/user_model/user_edit_form_model.dart';
import '../../data/service/auth_service.dart';

class UserService {
  static Future<void> updateProfile(UserEditFormModel data) async {
    try {
      final token = await AuthService.getToken();
      final res = await http.put(
        Uri.parse(API.updateProfile),
        body: data.toJson(),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updatePin(UserPinEditFormModel data) async {
    try {
      final token = await AuthService.getToken();
      final res = await http.put(
        Uri.parse(API.updatePin),
        body: data.toJson(),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<UserModel>> getRecentUser() async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse(API.transferHistories),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<UserModel>.from(jsonDecode(res.body)['data']
            .map((item) => UserModel.fromJson(item)));
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<UserModel>> getUserByUsername(String username) async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse('${API.getUserByUsername}/$username'),
        headers: {
          'Authorization': token,
        },
      );
      if (res.statusCode == 200) {
        return List<UserModel>.from(
            jsonDecode(res.body).map((item) => UserModel.fromJson(item)));
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
