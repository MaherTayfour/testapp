import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:getx_pagination/core/controller/login_controller.dart';
import 'package:getx_pagination/core/controller/LoginState.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: _SignInForm(),
        ));
  }
}


class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Form(
        key: _key,
        autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Center(
          child: SingleChildScrollView(
            child: Column(

              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Login',style: GoogleFonts.anton(
                      textStyle: TextStyle(fontSize: 50,color: Color(0xFFFF5300))
                  ), ),
                  ],),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(const Radius.circular(15))
                      ),
                      labelText: 'Email address',
                      prefixIcon: Icon(FontAwesomeIcons.envelope),

                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null) {
                        return 'Email is required.';
                      }
                      return null;
                    },
                  ),
                  width: MediaQuery.of(context).size.width/1.2,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(const Radius.circular(15))
                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(FontAwesomeIcons.lockOpen),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null) {
                        return 'Password is required.';
                      }
                      return null;
                    },
                  ),
                  width: MediaQuery.of(context).size.width/1.2,
                ),
                const SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('LOG IN'),
                  onPressed: _controller.state is LoginLoading ? () {} : _onLoginButtonPressed,
                ),
                const SizedBox(height: 20,),
                if (_controller.state is LoginFailure)
                  Text((_controller.state as LoginFailure).error,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Get.theme.errorColor
                    ),
                  ),
                if (_controller.state is LoginLoading)
                  Center(child: CircularProgressIndicator(),)
              ],
            ),
          ),
        ),
      );
    });
  }

  _onLoginButtonPressed() {
    if (_key.currentState.validate()) {
      _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}