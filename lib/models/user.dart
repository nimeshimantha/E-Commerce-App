import 'package:flutter/foundation.dart';

class UserProfile with ChangeNotifier {
  String? _name;
  String? _email;
  String? _phone;
  String? _address;
  String? _avatarUrl;

  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;
  String? get avatarUrl => _avatarUrl;
  bool get isSignedIn => _email != null && _email!.isNotEmpty;

  void setUser({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? avatarUrl,
  }) {
    _name = name;
    _email = email;
    if (phone != null) _phone = phone;
    if (address != null) _address = address;
    if (avatarUrl != null) _avatarUrl = avatarUrl;
    notifyListeners();
  }

  void updateDetails({
    String? name,
    String? phone,
    String? address,
  }) {
    if (name != null) _name = name;
    if (phone != null) _phone = phone;
    if (address != null) _address = address;
    notifyListeners();
  }

  void signOut() {
    _name = null;
    _email = null;
    _phone = null;
    _address = null;
    _avatarUrl = null;
    notifyListeners();
  }

  // Cloud Firestore map serialization
  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'email': _email,
      'phone': _phone,
      'address': _address,
      'avatarUrl': _avatarUrl,
    };
  }

  void fromMap(Map<String, dynamic> map) {
    _name = map['name'] as String?;
    _email = map['email'] as String?;
    _phone = map['phone'] as String?;
    _address = map['address'] as String?;
    _avatarUrl = map['avatarUrl'] as String?;
    notifyListeners();
  }
}
