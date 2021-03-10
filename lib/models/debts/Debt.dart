import 'package:financial_app/models/debts/DebtType.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'dart:math';

part 'Debt.g.dart';

@HiveType(typeId: 2)
class Debt {
  @HiveField(0)
  String id;
  @HiveField(1)
  DebtType debtType;
  @HiveField(2)
  String person;
  @HiveField(3)
  int accumulations;
  @HiveField(4)
  int total;
  Debt(
      {@required this.person,
      @required this.total,
      @required this.accumulations,
      @required this.debtType}) {
    final rand = new Random();
    final codeUnits = new List.generate(10, (index) {
      return rand.nextInt(33) + 89;
    });
    this.id = String.fromCharCodes(codeUnits);
  }
}
