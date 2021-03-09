import 'package:financial_app/models/costs/Cost.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CostsModel extends ChangeNotifier {
  static const String BOX_NAME = "costs";

  Map<String, List<Cost>> _costsMap = {};
  Map<String, List<Cost>> get costsMap => this._costsMap;

  Box _storageBox;

  CostsModel() {
    this._init();
  }

  _init() async {
    this._storageBox = await Hive.openBox<Map>(BOX_NAME);
    this._storageBox.values.forEach((boxValue) {
      Map<String, List>.from(boxValue).forEach((key, value) {
        value = List<Cost>.from(value);
        this._costsMap[key] = value;
      });
    });
    notifyListeners();
  }

  void addCostCategory(String label) {
    _costsMap = {label: [], ..._costsMap};
    this._storageBox.put(label.hashCode, {label: []});
    notifyListeners();
  }

  void addCost(String categoryLabel, Cost cost) {
    _costsMap[categoryLabel] = [cost, ..._costsMap[categoryLabel]];
    this
        ._storageBox
        .put(categoryLabel.hashCode, {categoryLabel: _costsMap[categoryLabel]});
    notifyListeners();
  }

  void removeCost(String categoryLabel, int costIndex) {
    _costsMap[categoryLabel].removeAt(costIndex);
    this
        ._storageBox
        .put(categoryLabel.hashCode, {categoryLabel: _costsMap[categoryLabel]});
    notifyListeners();
  }

  void removeCostCategory(String categoryLabel) {
    _costsMap.remove(categoryLabel);
    this._storageBox.delete(categoryLabel.hashCode);
    notifyListeners();
  }

  int getCategorySum(String category) =>
      _costsMap.length != 0 && _costsMap[category].length != 0
          ? _costsMap[category]
              .map((cost) => cost.value)
              .reduce((acc, value) => acc + value)
          : 0;

  int get totalCostsSum => _costsMap.length != 0
      ? _costsMap.entries
          .map((category) => getCategorySum(category.key))
          .reduce((acc, categorySum) => acc + categorySum)
      : 0;

  List<CostCategory> get costCategorysList => _costsMap.length != 0
      ? _costsMap.entries
          .map((category) => CostCategory(
              label: category.key, categorySum: getCategorySum(category.key)))
          .toList()
      : [];
}

class CostCategory {
  String label;
  int categorySum;
  CostCategory({@required this.label, @required this.categorySum});
}
