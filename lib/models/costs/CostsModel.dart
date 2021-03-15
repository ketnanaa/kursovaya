import 'package:financial_app/models/costs/Cost.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

/**
 * Модель для управления состоянием коллекции трат
 */
class CostsModel extends ChangeNotifier {
  static const String BOX_NAME = "costs";

  Map<String, List<Cost>> _costsMap = {};
  Map<String, List<Cost>> get costsMap => this._costsMap;

  Box _storageBox;

  CostsModel() {
    this._init();
  }
  /**
   * Инициализация модели, при которой проверяется
   * зарезервированное пространство в файловой системе.
   * При наличии данных модель заполняется этими данными,
   * при их отсутствии создается пустая модель 
   */
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

  /**
   * Создание новой категории расходов
   */
  void addCostCategory(String label) {
    _costsMap = {label: [], ..._costsMap};
    this._storageBox.put(label.hashCode, {label: []});
    notifyListeners();
  }

  /**
   * Создание нового элемента расходов
   */
  void addCost(String categoryLabel, Cost cost) {
    _costsMap[categoryLabel] = [cost, ..._costsMap[categoryLabel]];
    this
        ._storageBox
        .put(categoryLabel.hashCode, {categoryLabel: _costsMap[categoryLabel]});
    notifyListeners();
  }

  /**
   * Удаление элемента расходов
   */
  void removeCost(String categoryLabel, int costIndex) {
    _costsMap[categoryLabel].removeAt(costIndex);
    this
        ._storageBox
        .put(categoryLabel.hashCode, {categoryLabel: _costsMap[categoryLabel]});
    notifyListeners();
  }

  /**
   * Удаление категории расходов
   */
  void removeCostCategory(String categoryLabel) {
    _costsMap.remove(categoryLabel);
    this._storageBox.delete(categoryLabel.hashCode);
    notifyListeners();
  }

  /**
   * Метод получения суммарных трат одной категории расходов
   */
  int getCategorySum(String category) =>
      _costsMap.length != 0 && _costsMap[category].length != 0
          ? _costsMap[category]
              .map((cost) => cost.value)
              .reduce((acc, value) => acc + value)
          : 0;

  /**
   * Метод получения суммы трат всех категорий
   */
  int get totalCostsSum => _costsMap.length != 0
      ? _costsMap.entries
          .map((category) => getCategorySum(category.key))
          .reduce((acc, categorySum) => acc + categorySum)
      : 0;

  /**
   * Метод получения списка категории расходов,
   * в формате необходимом для отрисовки виджетом списка категорий
   */
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
