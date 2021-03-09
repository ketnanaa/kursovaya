import 'package:financial_app/models/costs/CostsModel.dart';
import 'package:financial_app/models/incomes/IncomesModel.dart';
import 'package:financial_app/screens/HomeScreen/Balance/BalanceBanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalBalance extends StatelessWidget {
  final String _balanceLabel = "БАЛАНС";
  @override
  Widget build(BuildContext context) {
    int _costsSum = context.watch<CostsModel>().totalCostsSum;
    int _incomesSum = context.watch<IncomesModel>().incomesSum;
    return BalanceBanner(
        label: _balanceLabel, balance: _incomesSum - _costsSum);
  }
}
