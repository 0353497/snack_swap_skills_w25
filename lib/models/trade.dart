import 'package:hive/hive.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/user.dart';

part 'trade.g.dart';

@HiveType(typeId: 2)
class Trade extends HiveObject {
  @HiveField(0)
  final User fromUser;
  @HiveField(1)
  final Snack fromUserSnack;
  @HiveField(2)
  final User toUser;
  @HiveField(3)
  final Snack toUserSnack;
  //accepted, declined, pending,
  @HiveField(4)
  final String status;
  Trade(this.fromUser, this.fromUserSnack, this.toUser, this.toUserSnack, this.status);
}