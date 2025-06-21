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
      
      final authBloc = AuthBloc();
      authBloc.setCurrentUser(loggedInUser);
    } catch (e) {
      AuthBloc().logout();
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
      
      final authBloc = AuthBloc();
      authBloc.setCurrentUser(user);
    } catch (e) {
      throw Exception('Invalid username or password');
    }
  }
  
  static Future<void> logout() async {
    final authBloc = AuthBloc();
    final User? currentUser = authBloc.currentUserValue;
    if (currentUser != null) {
      currentUser.isLoggedIn = false;
      await currentUser.save();
      authBloc.logout();
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
    final authBloc = AuthBloc();
    final String? currentUserID = authBloc.currentUserValue?.userID;
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
  
  static bool userHasSnack(User user, String snackName) {
    final snacksBox = Hive.box<Snack>("snacks");
    try {
      snacksBox.values.firstWhere(
        (snack) => snack.userID == user.userID && snack.name == snackName
      );
      return true;
    } catch (e) {
      return false;
    }
  }
  
  static Future<void> cancelPendingTradesForSnack(User user, String snackName) async {
    final tradesBox = Hive.box<Trade>("trades");
    final pendingTrades = tradesBox.values.where((trade) => 
      trade.status == 'pending' && 
      trade.fromUser.userID == user.userID && 
      trade.fromUserSnack.name == snackName
    ).toList();
    
    for (var trade in pendingTrades) {
      await cancelTrade(trade);
    }
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
    bool fromUserHasSnack = userHasSnack(trade.fromUser, trade.fromUserSnack.name);
    bool toUserHasSnack = userHasSnack(trade.toUser, trade.toUserSnack.name);
    
    if (!fromUserHasSnack || !toUserHasSnack) {
      await cancelTrade(trade);
      return;
    }
    
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
    
    final snacksBox = Hive.box<Snack>("snacks");
    final fromUserSnackIndex = snacksBox.values.toList().indexWhere(
      (snack) => snack.userID == trade.fromUser.userID && snack.name == trade.fromUserSnack.name
    );
    final toUserSnackIndex = snacksBox.values.toList().indexWhere(
      (snack) => snack.userID == trade.toUser.userID && snack.name == trade.toUserSnack.name
    );
    
    if (fromUserSnackIndex != -1 && toUserSnackIndex != -1) {
      final fromUserSnackKey = snacksBox.keyAt(fromUserSnackIndex);
      final toUserSnackKey = snacksBox.keyAt(toUserSnackIndex);
      
      final fromUserSnack = snacksBox.get(fromUserSnackKey);
      final toUserSnack = snacksBox.get(toUserSnackKey);
      
      if (fromUserSnack != null && toUserSnack != null) {
        // Update haveTraded lists
        List<String> updatedFromUserHaveTraded = List<String>.from(fromUserSnack.haveTraded ?? []);
        List<String> updatedToUserHaveTraded = List<String>.from(toUserSnack.haveTraded ?? []);
        
        // Add the user IDs if they're not already in the list
        if (!updatedFromUserHaveTraded.contains(trade.toUser.userID)) {
          updatedFromUserHaveTraded.add(trade.toUser.userID);
        }
        
        if (!updatedToUserHaveTraded.contains(trade.fromUser.userID)) {
          updatedToUserHaveTraded.add(trade.fromUser.userID);
        }
        
        final newFromUserSnack = Snack(
          name: fromUserSnack.name,
          description: fromUserSnack.description,
          country: fromUserSnack.country,
          userID: trade.toUser.userID, // Swap the userID
          countryImgUrl: fromUserSnack.countryImgUrl,
          imageImgUrl: fromUserSnack.imageImgUrl,
          haveTraded: updatedFromUserHaveTraded // Update haveTraded list
        );
        
        final newToUserSnack = Snack(
          name: toUserSnack.name,
          description: toUserSnack.description,
          country: toUserSnack.country,
          userID: trade.fromUser.userID,
          countryImgUrl: toUserSnack.countryImgUrl,
          imageImgUrl: toUserSnack.imageImgUrl,
          haveTraded: updatedToUserHaveTraded // Update haveTraded list
        );
        
        await snacksBox.delete(fromUserSnackKey);
        await snacksBox.delete(toUserSnackKey);
        
        await snacksBox.add(newFromUserSnack);
        await snacksBox.add(newToUserSnack);
        
        await cancelPendingTradesForSnack(trade.fromUser, trade.fromUserSnack.name);
        await cancelPendingTradesForSnack(trade.toUser, trade.toUserSnack.name);
      }
    }
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
    final authBloc = AuthBloc();
    final User? currentUser = authBloc.currentUserValue;
    if (currentUser == null) return;
    
    if (!userHasSnack(currentUser, mySnack.name)) {
      return;
    }
    
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
    final authBloc = AuthBloc();
    try {
      return usersBox.values.firstWhere(
        (user) => user.userID == snack.userID && user.userID != authBloc.currentUserValue?.userID,
      );
    } catch (e) {
      return null;
    }
  }
}