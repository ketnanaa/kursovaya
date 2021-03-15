import 'package:financial_app/common/constants.dart';
import 'package:financial_app/common/formats.dart';
import 'package:financial_app/common/Widgets/CustomTextField.dart';
import 'package:financial_app/common/Widgets/ListItem.dart';
import 'package:financial_app/common/Widgets/ModalWindow.dart';
import 'package:financial_app/models/debts/Debt.dart';
import 'package:financial_app/models/debts/DebtsModel.dart';
import 'package:financial_app/screens/HomeScreen/Widgets/ListHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DebtsModel _debtsModel = context.watch<DebtsModel>();
    List<Debt> _depositList = _debtsModel.depositList;
    isClosed(Debt debt) => debt.accumulations >= debt.total ? true : false;

    Widget _getReplanishAccDialog(BuildContext context, String debtId) {
      int value;
      return ModalWindow(
        buttonLabel: "Пополнить",
        tapHandler: () {
          if (value == null) {
            return;
          }
          context.read<DebtsModel>().replanishAccumulations(debtId, value);
          Navigator.pop(context);
        },
        child: Column(
          children: [
            CustomTextField.sum(
                onChanged: (newData) => value = int.parse(newData))
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(flex: 3, child: ListHeader(label: "ДЕПОЗИТ")),
        Expanded(
            flex: 9,
            child: _depositList.length != 0
                ? ListView(
                    children: _depositList
                        .map((Debt debt) => ListItem(
                              title: debt.person,
                              value: isClosed(debt)
                                  ? "${getMoneyFormat(debt.total)}"
                                  : "${getMoneyFormat(debt.accumulations)}/${getMoneyFormat(debt.total)}",
                              onDismiss: (DismissDirection dir) {
                                _debtsModel.removeDebt(debt.id);
                              },
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => ChangeNotifierProvider<
                                            DebtsModel>.value(
                                          value: Provider.of<DebtsModel>(
                                              context,
                                              listen: false),
                                          child: _getReplanishAccDialog(
                                              context, debt.id),
                                        ));
                              },
                            ))
                        .toList(),
                  )
                : Align(
                    child: Text(emptyListLabel,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w200)),
                  ))
      ],
    );
  }
}
