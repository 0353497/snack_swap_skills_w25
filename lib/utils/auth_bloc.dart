import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snack_swap/models/user.dart';

class AuthBloc {
  static final AuthBloc _instance = AuthBloc._internal();
  
  factory AuthBloc() => _instance;
  
  AuthBloc._internal() {
    _currentUser = BehaviorSubject<User?>();
  }
  
  late final BehaviorSubject<User?> _currentUser;
  
  ValueStream<User?> get currentUser => _currentUser.stream;
  User? get currentUserValue => _currentUser.valueOrNull;

  void setCurrentUser(User user) {
    _currentUser.add(user);
  }
  
  void logout() {
    _currentUser.add(null);
  }
  
  void dispose() {
    if (!_currentUser.isClosed) {
      _currentUser.close();
    }
  }

  bool login(String name, String password) {
    final Box usersBox = Hive.box<User>("users");
    List<User> users = usersBox.values.cast<User>().toList();
    final currentUser = users.where((user) => user.name == name && user.password == password).firstOrNull;
    if (currentUser == null) return false;
    currentUser.isLoggedIn = true;
    setCurrentUser(currentUser);
    return true;
  }
}
