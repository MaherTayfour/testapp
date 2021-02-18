import 'package:get/get.dart';

import 'package:getx_pagination/core/controller/auth_controller.dart';
import 'package:getx_pagination/core/controller/LoginState.dart';
import 'package:getx_pagination/core/network/auth_ser.dart';

class LoginController  extends GetxController {
  final AuthCont _authenticationController = Get.find();

  final _loginStateStream = LoginState().obs;

  LoginState get state => _loginStateStream.value;

  void login(String email, String password) async {
    _loginStateStream.value = LoginLoading();

    try{
      await _authenticationController.signIn(email, password);
      _loginStateStream.value = LoginState();
      Get.toNamed("/");
    } on AuthenticationException catch(e){
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }
}