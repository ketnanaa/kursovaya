import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';

part 'Goal.g.dart';

/**
 * Модель данных с аннотациями для создания
 * адаптера к библиотеке Hive
 */
@HiveType(typeId: 3)
class Goal {
  @HiveField(0)
  String label;
  @HiveField(1)
  int accumulations;
  @HiveField(2)
  int total;
  Goal(
      {@required this.label,
      @required this.total,
      @required this.accumulations});
}
