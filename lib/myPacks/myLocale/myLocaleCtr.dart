import 'package:beekeeper/main.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class MyLocaleCtr extends GetxController {
  //String codeLang = sharedPrefs!.getString('lang') ?? 'ar' : sharedPrefs!.getString('lang')!;
  Locale initlang = Locale(sharedPrefs!.getString('lang') ?? 'ar');



  void changeLang(String codeLang) {
    sharedPrefs!.setString('lang', codeLang);
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
    print('## current lang => ${currLang}');
  }
}
