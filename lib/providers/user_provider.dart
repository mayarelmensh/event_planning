import 'package:event_planning/my_user.dart';
import 'package:flutter/cupertino.dart';


class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  Future<void> updateUser(MyUser newUser) async {
    currentUser = newUser;
    notifyListeners();
  }
}

