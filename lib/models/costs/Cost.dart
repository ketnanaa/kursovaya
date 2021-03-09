import 'package:hive/hive.dart';
import 'package:flutter/cupertino.dart';

part 'Cost.g.dart';

@HiveType(typeId: 0)
class Cost {
  @HiveField(0)
  String label;
  @HiveField(1)
  int value;
  @HiveField(2)
  DateTime date;
  Cost({@required this.label, @required this.value, @required this.date});
}
