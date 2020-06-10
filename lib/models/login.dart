import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

//TODO Fix "Tried to use provider with a subtype of listenable/stream"

class LoginModel extends ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  String _userUID;
  Status _status = Status.Uninitialized;

  LoginModel.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  String get userUID => _user.uid;

  set (Status status) => _status = status;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Checkpoint for true');
    } catch (e) {
      print(e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      print('Checkpoint for false');
      return false;
    }
    _status = Status.Authenticated;
    notifyListeners();

    return true;
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}