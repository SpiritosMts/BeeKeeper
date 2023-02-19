


import 'package:beekeeper/addRequest/addRequestCtr.dart';
import 'package:beekeeper/addRequest/components/imagePicker/imageCtr.dart';
import 'package:beekeeper/addRequest/components/mapNoAddrPicker/mapCtr.dart';
import 'package:beekeeper/addRequest/components/radioPicker/radioCtr.dart';
import 'package:beekeeper/addRequest/components/textFields/fieldsCtr.dart';
import 'package:beekeeper/home/homeCtr.dart';
import 'package:beekeeper/myPacks/firebase/fireBaseAuth.dart';
import 'package:beekeeper/myPacks/mapVoids.dart';
import 'package:beekeeper/myPacks/myLocale/myLocaleCtr.dart';
import 'package:beekeeper/notifications/notificationCtr.dart';
import 'package:beekeeper/shop/shopCtr.dart';
import 'package:get/get.dart';

class GetxBinding implements Bindings {
  @override
  void dependencies() {


    ///auth
    Get.put(AuthController());






    //formular components
    Get.lazyPut<TextFieldsCtr>(() => TextFieldsCtr(),fenix: true);
    Get.lazyPut<MapPickerCtr>(() => MapPickerCtr(),fenix: true);
    Get.lazyPut<ImagePickerCtr>(() => ImagePickerCtr(),fenix: true);
    Get.lazyPut<RadioPickerCtr>(() => RadioPickerCtr(),fenix: true);

    //prod
    Get.lazyPut<AddRequestCtr>(() => AddRequestCtr(),fenix: true);
    Get.lazyPut<ShopCtr>(() => ShopCtr(),fenix: true);
    Get.lazyPut<HomeCtr>(() => HomeCtr(),fenix: true);
    Get.lazyPut<MapStyleCtr>(() => MapStyleCtr(),fenix: true);
    Get.lazyPut<MyNotifCtr>(() => MyNotifCtr(),fenix: true);
    Get.lazyPut<MyLocaleCtr>(() => MyLocaleCtr(),fenix: true);





    //print("## getx dependency injection completed (Get.put() )");

  }
}