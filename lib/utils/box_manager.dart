import 'package:hive/hive.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/user.dart';

class BoxManager {
  
  Future<void> init() async{
    await Hive.openBox("currentUser");
    await Hive.openBox("snacks");
    await Hive.openBox("users");
  }

  Box getSnacksBox() => Hive.box("snacks");
  Box getUsersBox() => Hive.box("users");
  Box getCurrentUserBox() => Hive.box("currentUser");

  Future<User?> getCurrentUser() async {
    final currentUserBox = getCurrentUserBox();
    final String? username = currentUserBox.get('username');
    if (username == null) return null;
    
    return getUser(username);
  }
  
  Future<User?> getUser(String username) async {
    final usersBox = getUsersBox();
    return usersBox.get(username);
  }

  Future<List<Snack>> getUserSnacks(String username) async {
    final User? user = await getUser(username);
    if (user == null) return [];
    return user.snacks;
  }
  
  Future<List<Snack>> getCurrentUserSnacks() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser == null) return [];
    return currentUser.snacks;
  }

  Future<void> addSnack(Snack snack) async {
    final snacksBox = getSnacksBox();
    await snacksBox.put(snack.name, snack);
    
    final User? user = await getUser(snack.currentUser);
    if (user != null) {
      user.snacks.add(snack);
      await user.save();
    }
  }
  
  Future<void> removeSnack(String snackName, String username) async {
    final User? user = await getUser(username);
    if (user == null) return;
    
    user.snacks.removeWhere((snack) => snack.name == snackName);
    await user.save();
  }
  
  Future<bool> tradeSnack(String snackName, String fromUsername, String toUsername) async {
    final User? fromUser = await getUser(fromUsername);
    final User? toUser = await getUser(toUsername);
    
    if (fromUser == null || toUser == null) return false;
    
    final snackIndex = fromUser.snacks.indexWhere((snack) => snack.name == snackName);
    if (snackIndex == -1) return false;
    
    final Snack snack = fromUser.snacks[snackIndex];
    final updatedSnack = Snack(
      name: snack.name,
      description: snack.description,
      total: snack.total,
      country: snack.country,
      currentUser: toUsername,
      countryImgUrl: snack.countryImgUrl,
      imageImgUrl: snack.imageImgUrl
    );
    
    fromUser.snacks.removeAt(snackIndex);
    toUser.snacks.add(updatedSnack);
    
    final snacksBox = getSnacksBox();
    await snacksBox.put(updatedSnack.name, updatedSnack);
    
    await fromUser.save();
    await toUser.save();
    
    return true;
  }
  
  Future<List<Snack>> getAllAvailableSnacks() async {
    final snacksBox = getSnacksBox();
    return snacksBox.values.cast<Snack>().toList();
  }
}