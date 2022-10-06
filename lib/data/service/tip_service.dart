import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/api.dart';
import '../../data/model/user_model/tip_model.dart';
import '../../data/service/auth_service.dart';

class TipService {
  static Future<List<TipModel>> getTips() async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse(API.getTips),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TipModel>.from(
            jsonDecode(res.body)['data'].map((tip) => TipModel.fromJson(tip)));
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
