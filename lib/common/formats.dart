import 'package:intl/intl.dart';

String getMoneyFormat(int number) => number.toString().length < 6
    ? NumberFormat.currency(locale: "ru", decimalDigits: 0, symbol: "₽")
        .format(number)
    : NumberFormat.compactCurrency(decimalDigits: 0, symbol: "₽")
        .format(number);

DateFormat getDateFormat() => new DateFormat("dd.MM.yyyy");

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}
