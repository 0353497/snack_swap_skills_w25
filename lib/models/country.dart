import 'package:hive/hive.dart';

part 'country.g.dart';

@HiveType(typeId: 3)
class Country extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String flagImageUrl;

  Country({
    required this.name,
    required this.flagImageUrl,
  });
}