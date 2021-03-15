import 'package:financial_app/models/goals/Goal.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

/**
 * Модель для управления состоянием коллекции целей
 */
class GoalsModel extends ChangeNotifier {
  static const String BOX_NAME = "goals";

  Map<String, Goal> _goalsMap = {};
  Map<String, Goal> get goalsMap => this._goalsMap;

  Box _storageBox;

  GoalsModel() {
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
      Map<String, Goal>.from(boxValue).forEach((key, value) {
        this._goalsMap[key] = value;
      });
    });
    notifyListeners();
  }

  /**
   * Метод получения списка актуальных целей
   */
  List<Goal> get currentGoals => _goalsMap.entries.length != 0
      ? _goalsMap.entries
          .where((entry) => entry.value.accumulations < entry.value.total)
          .map((e) => e.value)
          .toList()
      : [];

  /**
   * Метод получения списка закрытых целей
   */
  List<Goal> get achivedGoals => _goalsMap.entries.length != 0
      ? _goalsMap.entries
          .where((entry) => entry.value.accumulations >= entry.value.total)
          .map((e) => e.value)
          .toList()
      : [];

  /**
   * Метод добавления элемента цели
   */
  void addGoal(Goal goal) {
    _goalsMap = {goal.label: goal, ..._goalsMap};
    this._storageBox.put(goal.label.hashCode, {goal.label: goal});
    notifyListeners();
  }

  /**
   * Метод удаления элемента цели
   */
  void removeGoal(String label) {
    _goalsMap.remove(label);
    this._storageBox.delete(label.hashCode);
    notifyListeners();
  }

  /**
   * Метод пополнения накоплений цели
   */
  void replenishAccumulations(String label, int value) {
    int newValue = _goalsMap[label].accumulations + value;
    _goalsMap[label].accumulations =
        newValue <= _goalsMap[label].total ? newValue : _goalsMap[label].total;
    this._storageBox.put(label.hashCode, {label: _goalsMap[label]});
    notifyListeners();
  }

  /**
   * Метод закрытия цели
   */
  void achieveGoal(String label) {
    _goalsMap[label].accumulations = _goalsMap[label].total;
    this._storageBox.put(label.hashCode, {label: _goalsMap[label]});
    notifyListeners();
  }
}
