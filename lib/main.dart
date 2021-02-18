import 'package:flutter/material.dart';
import 'package:getx_pagination/core/controller/auth_controller.dart';
import 'package:getx_pagination/core/controller/auth_state.dart';
import 'package:getx_pagination/core/network/auth_ser.dart';
import 'package:get/get.dart';
import 'package:getx_pagination/view/screen/LoginPage.dart';
import 'view/screen/home/home_screen.dart';
import 'package:getx_pagination/core/bindings/application_binding.dart';
import 'package:getx_pagination/core/bindings/home_binding.dart';
import 'package:getx_pagination/core/routes/routes.dart';
void main() {
  initialize();
  runApp(MyApp());
}

void initialize() {
  Get.lazyPut(() => AuthCont(Get.put(FakeAuthenticationService())),);
}

class MyApp extends GetWidget<AuthCont> {
  String route='/';

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'TestApp',
        initialBinding: ApplicationBinding(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        getPages: routes);
  }
}