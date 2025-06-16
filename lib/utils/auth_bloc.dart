import 'package:rxdart/rxdart.dart';
import 'package:snack_swap/models/user.dart';

class AuthBloc {
  static final AuthBloc _instance = AuthBloc._internal();
  // Factory constructor to return the singleton instance
  factory AuthBloc() => _instance;
  
  AuthBloc._internal() {
    _currentUser = BehaviorSubject<User>();
  }
  
  late final BehaviorSubject<User?> _currentUser;
  
  ValueStream<User?> get currentUser => _currentUser.stream;
  User? get currentUserValue => _currentUser.valueOrNull;

  void setCurrentUser(User user) {
    _currentUser.add(user);
  }
  
  void clearCurrentUser() {
    if (!_currentUser.isClosed) {
      _currentUser.add(null);
    }
  }
  
  void dispose() {
    if (!_currentUser.isClosed) {
      _currentUser.close();
    }
  }
}
