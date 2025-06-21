
import 'package:hive/hive.dart';
import 'package:snack_swap/models/snack.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {

  @HiveField(0)
  final String userID;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String? countryImgUrl;
  @HiveField(5)
  final String? profileImg;
  @HiveField(6)
  final List<Snack>? tradedSnacks;
  @HiveField(7)
  bool isLoggedIn;

  User({
  required this.userID,
  required this.name,
  required this.password,
  required this.country,
  required this.countryImgUrl,
  this.isLoggedIn = false,
  this.profileImg,
  this.tradedSnacks
  });
}