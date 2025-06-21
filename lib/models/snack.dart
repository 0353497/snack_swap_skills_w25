import 'package:hive/hive.dart';
import 'package:snack_swap/utils/auth_bloc.dart';

part 'snack.g.dart';

@HiveType(typeId: 0)
class Snack extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String userID;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String? imageImgUrl;
  @HiveField(5)
  final String? countryImgUrl;

  //list of userIDS
  @HiveField(6)
  final List<String>? haveTraded;

  Snack({
  required this.name,
  required this.description,
  required this.country,
  required this.userID,
  this.countryImgUrl,
  this.imageImgUrl,
  this.haveTraded,
  });

  bool get hasCurrentUserTraded => (AuthBloc().currentUserValue != null && haveTraded != null) ? haveTraded!.contains(AuthBloc().currentUserValue!.userID) : false;
}