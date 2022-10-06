import 'package:intl/intl.dart';

class AppFormat {
  static String formatCurrency(int number, {String symbol = 'Rp '}) {
    return NumberFormat.currency(
      decimalDigits: 0,
      locale: 'id_ID',
      symbol: symbol,
    ).format(number);
  }

  static String date(String stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('MMM d yyyy', 'id_ID').format(dateTime);
  }
}

