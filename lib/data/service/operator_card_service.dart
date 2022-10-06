import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/api.dart';
import '../../data/model/operator_card/operator_card_model.dart';
import '../../data/service/auth_service.dart';

class OperatorCardService {
  static Future<List<OperatorCardModel>> getOperatorCard() async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse(API.getOperatorCards),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<OperatorCardModel>.from(jsonDecode(res.body)['data']
            .map((item) => OperatorCardModel.fromJson(item)));
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
