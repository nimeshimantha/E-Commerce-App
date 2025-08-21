import 'package:flutter/foundation.dart';

class UserProfile with ChangeNotifier {
  String? _name;
  String? _email;

  String? get name => _name;
  String? get email => _email;
  bool get isSignedIn => _email != null; // consider signed in if email is set

  void setUser({required String name, required String email}) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  void signOut() {
    _name = null;
    _email = null;
    notifyListeners();
  }
}
