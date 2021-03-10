import 'package:financial_app/models/debts/Debt.dart';
import 'package:financial_app/models/debts/DebtType.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class DebtsModel extends ChangeNotifier {
  static const String BOX_NAME = "debts";

  Map<String, Debt> _debtsMap = {};
  Map<String, Debt> get debtsMap => this._debtsMap;

  Box _storageBox;

  DebtsModel() {
    this._init();
  }

  _init() async {
    // this._storageBox.deleteFromDisk();
    this._storageBox = await Hive.openBox<Map>(BOX_NAME);
    this._storageBox.values.forEach((boxValue) {
      Map<String, Debt>.from(boxValue).forEach((key, value) {
        this._debtsMap[key] = value;
      });
    });
    notifyListeners();
  }

  List<Debt> get depositList => _debtsMap.values.toList().length != 0
      ? _debtsMap.values
          .toList()
          .where((debt) => debt.debtType == DebtType.deposit)
          .toList()
      : [];

  List<Debt> get loanList => _debtsMap.values.toList().length != 0
      ? _debtsMap.values
          .toList()
          .where((debt) => debt.debtType == DebtType.loan)
          .toList()
      : [];

  void removeDebt(String debtId) {
    _debtsMap.remove(debtId);
    this._storageBox.delete(debtId);
    notifyListeners();
  }

  void addDebt(Debt debt) {
    this._debtsMap[debt.id] = debt;
    this._storageBox.put(debt.id, {debt.id: debt});
    notifyListeners();
  }

  void replanishAccumulations(String debtId, int value) {
    int newValue = _debtsMap[debtId].accumulations + value;
    _debtsMap[debtId].accumulations = newValue <= _debtsMap[debtId].total
        ? newValue
        : _debtsMap[debtId].total;
    this._storageBox.put(debtId, {debtId: _debtsMap[debtId]});
    notifyListeners();
  }
}
