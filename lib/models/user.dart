import 'package:hive/hive.dart';
import 'package:snack_swap/models/snack.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String country;
  @HiveField(3)
  final String? countryImgUrl;
  @HiveField(4)
  final String? profileImg;
  @HiveField(5)
  final List<Snack> snacks;

  User({
  required this.name,
  required this.password,
  required this.country,
  required this.countryImgUrl,
  required this.snacks,
  this.profileImg, 
  });
}