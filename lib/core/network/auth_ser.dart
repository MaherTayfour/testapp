import 'package:getx_pagination/core/model/user_model.dart';
import 'package:get/get.dart';

abstract class AuthenticationService extends GetxService{
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    // simulated delay
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email.toLowerCase() != 'test@domain.com' || password != 't123') {
      throw AuthenticationException(message: 'Wrong username or password');
    }

    return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}