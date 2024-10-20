import 'package:crafty_boy_ecommerce_app/data/services/network_caller.dart';
import 'package:crafty_boy_ecommerce_app/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavBarController());
    Get.put(()=>Logger());
    Get.put(()=> NetworkCaller(logger: Get.find<Logger>()));
  }

}