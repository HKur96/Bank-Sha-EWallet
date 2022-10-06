import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config/api.dart';
import '../../data/model/transaction_model/payment_method_model.dart';
import '../../data/service/auth_service.dart';

class PaymentMethodService {
  static Future<List<PaymentMethodModel>> getPaymentMethod() async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse(API.getPaymentMethod),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<PaymentMethodModel>.from(jsonDecode(res.body)
            .map((item) => PaymentMethodModel.fromJson(item)));
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
