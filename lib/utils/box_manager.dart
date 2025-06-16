import 'package:hive/hive.dart';

class BoxManager {
  Future<void> init() async{
    await Hive.openBox("currentUser");
    await Hive.openBox("snacks");
  }
}