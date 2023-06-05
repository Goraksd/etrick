import 'dart:async';

import 'package:etrick/models/app_user.dart';
import 'package:etrick/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get user => _auth.currentUser;

  bool get isSignedIn => _auth.currentUser != null;

  void initialize() {
    authStateChanges.listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  bool isEmailValid(String email) {
    return RegExp(r'^.+@.+\..+$').hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return RegExp(r'^.{8,}$').hasMatch(password);
  }

  bool isFirstNameValid(String firstName) {
    return RegExp(r'^.{2,}$').hasMatch(firstName);
  }

  bool isLastNameValid(String lastName) {
    return RegExp(r'^.{2,}$').hasMatch(lastName);
  }

  Future<Map<bool, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(
          '[signInWithEmailAndPassword] User: ${_auth.currentUser!.email} is logged in!');
      return {
        true: "success",
      };
    } on FirebaseAuthException catch (e) {
      print('[signInWithEmailAndPassword] FirebaseAuthException: $e');
      return {
        false: e.toString(),
      };
    } catch (e) {
      print('[signInWithEmailAndPassword] error$e');
      return {
        false: e.toString(),
      };
    }
  }

  String getFirebaseAuthErrorMessage(String errorString) {
    String errorCode = errorString
        .substring(errorString.indexOf("(") + 1, errorString.indexOf(")"))
        .replaceAll("auth/", "");
    switch (errorCode) {
      case 'invalid-email':
      case 'user-not-found':
        return 'Користувача з таким email не знайдено';
      case 'wrong-password':
        return 'Невірний пароль';
      case 'user-disabled':
        return 'Користувача заблоковано';
      case 'too-many-requests':
        return 'Забагато спроб. Спробуйте пізніше';
      case 'operation-not-allowed':
        return 'Операція не дозволена';
      case 'email-already-in-use':
        return 'Користувач з таким email вже існує';
      case 'weak-password':
        return 'Пароль занадто простий';
      default:
        return errorString.substring(errorString.indexOf("] ") + 2);
    }
  }

  Future<void> signOut() async {
    print('Signing out');
    await _auth.signOut();
  }

  Future<Map<bool, String>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('[resetPassword] Email sent');
      return {
        true: "success",
      };
    } on FirebaseAuthException catch (e) {
      print('[resetPassword] FirebaseAuthException: $e');
      return {
        false: e.toString(),
      };
    } catch (e) {
      print('[resetPassword] error$e');
      return {
        false: e.toString(),
      };
    }
  }

  Future<Map<bool, String>> createAccount(
      AppUser appUser, String password) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: appUser.email,
        password: password,
      );
      print('[createAccount] User: ${_auth.currentUser!.email} is created!');
      await _auth.currentUser!
          .updateDisplayName('${appUser.firstName} ${appUser.lastName}');
      await FirestoreService.createUser(appUser.copyWith(
        id: user.user!.uid,
        email: user.user!.email,
      ));
      return {
        true: "success",
      };
    } on FirebaseAuthException catch (e) {
      print('[createAccount] FirebaseAuthException: $e');
      return {
        false: e.toString(),
      };
    } catch (e) {
      print('[createAccount] error$e');
      return {
        false: e.toString(),
      };
    }
  }

  // login
  Future<Map<bool, String>> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('[login] User: ${_auth.currentUser!.email} is logged in!');
      return {
        true: "success",
      };
    } on FirebaseAuthException catch (e) {
      print('[login] FirebaseAuthException: $e');
      return {
        false: e.toString(),
      };
    } catch (e) {
      print('[login] error$e');
      return {
        false: e.toString(),
      };
    }
  }
}
