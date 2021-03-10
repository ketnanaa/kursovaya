import 'package:financial_app/screens/DebtsScreen/DepositList.dart';
import 'package:financial_app/screens/DebtsScreen/LoanList.dart';
import 'package:flutter/material.dart';

class DebtsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 14, child: DepositList()),
        Spacer(),
        Expanded(flex: 14, child: LoanList()),
        Spacer(),
      ],
    );
  }
}
