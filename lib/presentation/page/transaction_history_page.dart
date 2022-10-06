import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/app_color.dart';
import '../../bloc/transaction_history/transaction_history_bloc.dart';
import '../widget/latest_transaction_item.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);
  static const routeName = '/transaction-history';

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
        builder: (context, state) {
          if (state is TransactionHistorySuccess) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 20),
                Column(
                  children: state.data.map((item) {
                    index++;
                    return Container(
                      margin: EdgeInsets.only(top: (index != 1) ? 18 : 0),
                      child: LatestTransactionItem(transaction: item),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Tidak ada data',
                  style: AppColor.blackTextStyle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
