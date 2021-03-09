import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class IncomesModel extends ChangeNotifier {
  static const String BOX_NAME = "incomes";

  Map<String, int> _incomesMap = {};

  Box _storageBox;

  IncomesModel() {
    this._init();
  }

  _init() async {
    this._storageBox = await Hive.openBox<Map>(BOX_NAME);
    this._storageBox.values.forEach((boxValue) {
      Map<String, int>.from(boxValue).forEach((key, value) {
        this._incomesMap[key] = value;
      });
    });
    notifyListeners();
  }

  Map<String, int> get incomesMap => this._incomesMap;

  int get incomesSum => this._incomesMap.length != 0
      ? this
          ._incomesMap
          .entries
          .map((income) => income.value)
          .toList()
          .reduce((acc, value) => acc + value)
      : 0;

  void addIncome(String label, int value) {
    this._incomesMap = {label: value, ...this._incomesMap};
    this._storageBox.put(label.hashCode, {label: value});
    notifyListeners();
  }

  void removeIncome(String label) {
    this._incomesMap.remove(label);
    this._storageBox.delete(label.hashCode);
    notifyListeners();
  }
}
