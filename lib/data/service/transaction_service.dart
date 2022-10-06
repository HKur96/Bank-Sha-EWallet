import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_bank_sha/data/model/operator_card/data_plan_form_model.dart';

import '../../data/model/transaction_model/transaction_history_model.dart';
import '../../data/model/transaction_model/transfer_form_model.dart';
import '../../config/api.dart';
import '../../data/service/auth_service.dart';
import '../../data/model/transaction_model/top_up_form_model.dart';

class TransactionService {
  static Future<String> topUp(TopUpFormModel data) async {
    try {
      final token = await AuthService.getToken();
      final res = await http.post(
        Uri.parse(API.topup),
        body: data.toJson(),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['redirect_url'];
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService.getToken();
      final res = await http.post(
        Uri.parse(API.transfer),
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

  static Future<List<TransactionHistoryModel>> getTransactionHistory() async {
    try {
      final token = await AuthService.getToken();
      final res = await http.get(
        Uri.parse(API.getTransaction),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TransactionHistoryModel>.from(jsonDecode(res.body)['data']
            .map((item) => TransactionHistoryModel.fromJson(item)));
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> buyDataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService.getToken();
      final res = await http.post(
        Uri.parse(API.dataPlan),
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
}
