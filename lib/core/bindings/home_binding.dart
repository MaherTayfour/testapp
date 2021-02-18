import 'package:get/get.dart';
import 'package:getx_pagination/core/controller/home_controller.dart';
import 'package:getx_pagination/core/repository/image_repository.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageRepository(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
