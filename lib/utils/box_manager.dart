import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:snack_swap/data/seedingdata.dart';
import 'package:snack_swap/models/country.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/trade.dart';
import 'package:snack_swap/models/user.dart';
import 'package:snack_swap/utils/auth_bloc.dart';

class BoxManager {
  
  static Future<void> init() async {
    await Hive.openBox<Snack>("snacks");
    await Hive.openBox<User>("users");
    await Hive.openBox<Trade>("trades");
    await Hive.openBox<Country>("countries");
    
    await _seedDataIfNeeded();
    await _tryAutoLogin();
  }

  static Future<void> _tryAutoLogin() async {
    final usersBox = Hive.box<User>("users");
    try {
      final loggedInUser = usersBox.values.firstWhere(
        (user) => user.isLoggedIn == true
      );
      
      AuthBloc().setCurrentUser(loggedInUser);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> _seedDataIfNeeded() async {
    final usersBox = Hive.box<User>("users");
    final snacksBox = Hive.box<Snack>("snacks");
    final countriesBox = Hive.box<Country>("countries");
    
    if (usersBox.isEmpty) {
      for (var user in seedingUsers) {
        await usersBox.add(user);
      }
    }
    
    if (snacksBox.isEmpty) {
      for (var snack in snacks) {
        await snacksBox.add(snack);
      }
    }
    
    if (countriesBox.isEmpty) {
      for (var country in countries) {
        await countriesBox.add(country);
      }
    }
  }

  static Future<void> login(String username, String password) async {
    final usersBox = Hive.box<User>("users");
    try {
      final user = usersBox.values.firstWhere(
        (user) => user.name == username && user.password == password
      );
      user.isLoggedIn = true;
      await user.save();
      
      AuthBloc().setCurrentUser(user);
    } catch (e) {
      throw Exception('Invalid username or password');
    }
  }
  
  static Future<void> logout() async {
    final User? currentUser = AuthBloc().currentUserValue;
    if (currentUser != null) {
      currentUser.isLoggedIn = false;
      await currentUser.save();
      AuthBloc().logout();
    }
  }

  static Future<void> addSnack(Snack snack) async {
    final snacksBox = Hive.box<Snack>("snacks");
    await snacksBox.add(snack);
  }
  
  static List<Snack> getUserSnacks(String userId) {
    final snacksBox = Hive.box<Snack>("snacks");
    return snacksBox.values.where((snack) => snack.userID == userId).toList();
  }
  static List<Snack> getCurrentUserSnacks() {
    final String? currentUserID = AuthBloc().currentUserValue?.userID;
    if (currentUserID == null) return <Snack>[];
    return getUserSnacks(currentUserID);
  }
  
  static List<Snack> getAllSnacks() {
    final snacksBox = Hive.box<Snack>("snacks");
    return snacksBox.values.toList();
  }
  
  
  static List<Snack> getAllUniqueSnacks() {
    final snacksBox = Hive.box<Snack>("snacks");
    final uniqueSnacks = <String, Snack>{};
    
    for (var snack in snacksBox.values) {
      uniqueSnacks[snack.name] = snack; 
    }
    
    return uniqueSnacks.values.toList();
  }

  static List<Trade> getUserTrades(User user) {
    final tradesBox = Hive.box<Trade>("trades");
    return tradesBox.values.where((trade) => 
      trade.fromUser.name == user.name || trade.toUser.name == user.name
    ).toList();
  }
  
  static List<Trade> getPendingTrades(User user) {
    final tradesBox = Hive.box<Trade>("trades");
    return tradesBox.values.where((trade) => 
      trade.toUser.name == user.name && trade.status == 'pending'
    ).toList();
  }
  
  static Future<void> declineTrade(Trade trade) async {
    final updatedTrade = Trade(
      trade.fromUser,
      trade.fromUserSnack,
      trade.toUser,
      trade.toUserSnack,
      'declined'
    );
    
    final key = Hive.box<Trade>("trades").keyAt(
      Hive.box<Trade>("trades").values.toList().indexOf(trade)
    );
    await Hive.box<Trade>("trades").put(key, updatedTrade);
  }
  
  static Future<void> acceptTrade(Trade trade) async {
    final updatedTrade = Trade(
      trade.fromUser,
      trade.fromUserSnack,
      trade.toUser,
      trade.toUserSnack,
      'accepted'
    );
    
    final key = Hive.box<Trade>("trades").keyAt(
      Hive.box<Trade>("trades").values.toList().indexOf(trade)
    );
    await Hive.box<Trade>("trades").put(key, updatedTrade);
  }
  
  static Future<void> cancelTrade(Trade trade) async {
    final key = Hive.box<Trade>("trades").keyAt(
      Hive.box<Trade>("trades").values.toList().indexOf(trade)
    );
    await Hive.box<Trade>("trades").delete(key);
  }
  
  static List<Trade> getAcceptedTrades(User user) {
    final tradesBox = Hive.box<Trade>("trades");
    return tradesBox.values.where((trade) => 
      (trade.fromUser.name == user.name || trade.toUser.name == user.name) && 
      trade.status == 'accepted'
    ).toList();
  }
  
  static List<Trade> getSentPendingTrades(User user) {
    final tradesBox = Hive.box<Trade>("trades");
    return tradesBox.values.where((trade) => 
      trade.fromUser.name == user.name && trade.status == 'pending'
    ).toList();
  }
  
  static Future<void> createTrade(User toUser, Snack toUserSnack, Snack mySnack) async {
    final User? currentUser = AuthBloc().currentUserValue;
    if (currentUser == null) return;
    
    final tradesBox = Hive.box<Trade>("trades");
    final trade = Trade(currentUser, mySnack, toUser, toUserSnack, 'pending');
    await tradesBox.add(trade);
  }
  
  static Country? getCountryByName(String name) {
    final countriesBox = Hive.box<Country>("countries");
    try {
      return countriesBox.values.firstWhere((country) => country.name == name);
    } catch (e) {
      return null;
    }
  }
  
  static User? getUserWithSnack(Snack snack) {
    final usersBox = Hive.box<User>("users");
    try {
      return usersBox.values.firstWhere(
        (user) => user.userID == snack.userID && user.userID != AuthBloc().currentUserValue?.userID,
      );
    } catch (e) {
      return null;
    }
  }
}