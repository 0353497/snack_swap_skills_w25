import 'package:hive/hive.dart';

part 'snack.g.dart';

@HiveType(typeId: 0)
class Snack extends HiveObject {

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final int total;
  @HiveField(3)
  final String currentUser;
  @HiveField(4)
  final String country;
  @HiveField(5)
  final String? imageImgUrl;
  @HiveField(6)
  final String? countryImgUrl;

  Snack({
  required this.name,
  required this.description,
  required this.total,
  required this.country,
  required this.currentUser,
  this.countryImgUrl,
  this.imageImgUrl
  });
}