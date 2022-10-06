import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/app_asset.dart';
import '../../config/app_color.dart';
import '../../config/app_format.dart';
import '../../data/model/transaction_model/transaction_history_model.dart';


class LatestTransactionItem extends StatelessWidget {
  final TransactionHistoryModel transaction;
  const LatestTransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image(String code) {
      String result = '';
      if (code == 'top_up') {
        result = AppAsset.icTransactionCat1;
      } else if (code == 'internet') {
        result = AppAsset.icTransactionCat5;
      } else if (code == 'transfer') {
        result = AppAsset.icTransactionCat4;
      }
      return result;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              image(transaction.transactionType!.code!),
              width: 48,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.transactionType!.name!,
                  style: AppColor.blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppColor.medium,
                  ),
                ),
                Text(
                  DateFormat('MMM dd')
                      .format(transaction.createdAt ?? DateTime.now()),
                  style: AppColor.greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppFormat.formatCurrency(transaction.amount ?? 0,
                  symbol: (transaction.transactionType!.action == 'cr')
                      ? '+ '
                      : '- '),
              style: AppColor.blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: AppColor.medium,
              ),
            )
          ],
        ),
      ],
    );
  }
}