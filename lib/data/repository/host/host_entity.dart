import 'package:isar/isar.dart';

part 'host_entity.g.dart';

@collection
class HostEntity {
  Id id = Isar.autoIncrement;
  late String host;
  late List<int> openPorts;
  late DateTime createdAt;
  late bool isFavorite;
}
