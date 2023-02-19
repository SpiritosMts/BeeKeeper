import 'dart:async';
import 'dart:ui';
import 'package:beekeeper/myPacks/myLocale/myLocaleCtr.dart';
import 'package:beekeeper/notifications/awesomeNotif.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bindings.dart';
import 'myPacks/myLocale/myLocale.dart';
import 'myPacks/myTheme/myTheme.dart';
import 'loadingScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

SharedPreferences? sharedPrefs;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



Future<void> initFirebase() async {  /// FIREBASE_INIT

  await Firebase.initializeApp();

}
Future<void> main() async {
  print('##run_main');
  await WidgetsFlutterBinding.ensureInitialized();//don't touch

  initFirebase();
  ///PREFS
  sharedPrefs = await SharedPreferences.getInstance();

  await NotificationController.initializeLocalNotifications(debug: true);//awesome notif



  /// RUN_APP
  runApp(MyApp()); //should contain materialApp
}

///################################################################################################################
///################################################################################################################
//
class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  MyLocaleCtr langCtr =   Get.put(MyLocaleCtr());  //lang
  //MyThemeCtr themeCtr =   Get.put(MyThemeCtr());  //theme
  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'BeeKeeper',

            theme: customLightTheme,
            //darkTheme: customDarkTheme,
            themeMode: ThemeMode.system,

            locale: langCtr.initlang,

            translations: MyLocale(),


            initialBinding: GetxBinding(),
            //initialRoute: '/',
            getPages: [
              //GetPage(name: '/', page: () => LoadingScreen()), //bf production
              GetPage(name: '/', page: () => LoadingScreen()),//in test mode

            ],
          );
        }
    );
  }
}


/// Buttons Page Route
class ScreenManager extends StatefulWidget {
  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}


class _ScreenManagerState extends State<ScreenManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[


          // TextButton(
          //     onPressed: () {
          //       authCtr.signOut();
          //     },
          //     child: Text('sign out')),
          TextButton(
              onPressed: () {
                Get.to(() => LoadingScreen());
              },
              child: Text('LoadingScreen<MAIN_APP>')),



        ],
      ),
    );
  }
}

