import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

/**
 * Модель для управления состоянием коллекции доходов
 */
class IncomesModel extends ChangeNotifier {
  static const String BOX_NAME = "incomes";

  Map<String, int> _incomesMap = {};

  Box _storageBox;

  IncomesModel() {
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
      Map<String, int>.from(boxValue).forEach((key, value) {
        this._incomesMap[key] = value;
      });
    });
    notifyListeners();
  }

  Map<String, int> get incomesMap => this._incomesMap;

  /**
   * Метод получения суммы всех доходов
   */
  int get incomesSum => this._incomesMap.length != 0
      ? this
          ._incomesMap
          .entries
          .map((income) => income.value)
          .toList()
          .reduce((acc, value) => acc + value)
      : 0;

  /**
   * Метод добавления дохода
   */
  void addIncome(String label, int value) {
    this._incomesMap = {label: value, ...this._incomesMap};
    this._storageBox.put(label.hashCode, {label: value});
    notifyListeners();
  }

  /**
   * Метод удаления дохода
   */
  void removeIncome(String label) {
    this._incomesMap.remove(label);
    this._storageBox.delete(label.hashCode);
    notifyListeners();
  }
}
