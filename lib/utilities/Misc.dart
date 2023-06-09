import 'package:intl/intl.dart';

class Misc {
  static final NumberFormat _currencyFormat = NumberFormat('#,##0.00');

  static String formatCurrency(double amount) {
    return _currencyFormat.format(amount);
  }
}