import 'package:flutter/cupertino.dart';

/**
 * Модель для управления состоянием приложения(навигация, заголовок текущего экрана)
 */
class AppModel extends ChangeNotifier {
  final List<String> _screenLabels = ["ГЛАВНАЯ", "ЦЕЛИ", "ДОЛГИ", "СТАТИСТИКА"];
  int _currentScreenIndex = 0;
  get currentScreenIndex => _currentScreenIndex;
  get currentScreenLabel => _screenLabels[_currentScreenIndex];
  void changeScreen(int index) {
    this._currentScreenIndex = index;
    notifyListeners();
  }
}
