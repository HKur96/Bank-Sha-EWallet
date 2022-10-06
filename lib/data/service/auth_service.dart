import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/model/auth_model/sign_in_form_model.dart';
import '../../data/model/auth_model/sign_up_form_model.dart';
import '../../data/model/auth_model/user_model.dart';
import '../../config/api.dart';

class AuthService {
  static Future<bool> checkEmail(String email) async {
    try {
      final res = await http.post(
        Uri.parse(API.checkEmail),
        body: {
          'email': email,
        },
      );
      if (res.statusCode == 200) {
        return jsonDecode(res.body)['is_email_exist'];
      }
      throw jsonDecode(res.body)['errors']['email'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> register(SignUpFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse(API.register),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(password: data.password);
        storeCredential(user);
        return user;
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> storeCredential(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'token', value: user.token);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> login(SignInFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse(API.login),
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(password: data.password);
        storeCredential(user);
        return user;
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<SignInFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, dynamic> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        return SignInFormModel(
          email: values['email'],
          password: values['password'],
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    String token = '';
    String? value = await storage.read(key: 'token');
    if (value != null) {
      token = 'Bearer $value';
    }
    return token;
  }

  static Future<void> logout() async {
    try {
      final token = await getToken();
      final res = await http.post(
        Uri.parse(API.logout),
        headers: {
          'Authorization': token,
        },
      );
      clearLocalStorage();
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
