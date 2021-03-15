import 'package:hive/hive.dart';

part 'DebtType.g.dart';

/**
 * Модель данных типа Enum(перечисление), с аннотациями для создания
 * адаптера к библиотеке Hive
 */
@HiveType(typeId: 1)
enum DebtType {
  @HiveField(0)
  deposit,
  @HiveField(1)
  loan
}
