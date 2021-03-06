import 'package:get/get.dart';
import 'package:getx_pagination/core/network/auth_ser.dart';
import 'package:getx_pagination/core/controller/auth_state.dart';

class AuthCont extends GetxController{
  final AuthenticationService _authenticationService;
  final _authenticationStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  AuthCont(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }
  Future<void> signIn(String email, String password) async {
    final user = await _authenticationService.signInWithEmailAndPassword(email, password);
    _authenticationStateStream.value = Authenticated(user: user);
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }




}