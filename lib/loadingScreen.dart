/// show loading (while verifying user account)

import 'dart:async';
import 'dart:io';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'myPacks/myVoids.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _VerifySigningInState();
}

class _VerifySigningInState extends State<LoadingScreen> {



  late bool canShowCnxFailed;
  late Timer timer;

  @override
  void initState() {
    super.initState();
     canShowCnxFailed =true ;

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkCnx();
    });
  }




  /// check connection state
  checkCnx() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      /// connected to internet
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('## connected');

        timer.cancel();
        authCtr.fetchUser();

      }
      /// failed to connect to internet
    } on SocketException catch (_) {
      print('## not connected');
      if(canShowCnxFailed){
        MyVoids().showVerifyConnexion();

        if(this.mounted){
          setState((){
            canShowCnxFailed=false;
          });
        }

      }
    }
  }



  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              SizedBox(
                height: 100.h/15,
              ),
              /// logo Image
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 170,
                ),
              ),
              SizedBox(height: 10),
              // text
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(),
                  child: Text(
                    'keep ecosystem safe'.tr,
                      textAlign: TextAlign.center,

                      style:TextStyle(
                          fontSize: 21.sp,
                          color: Colors.white,
                        height: 1.5

                      )

                  ),
                ),
              ),
              // check your cnx
              !canShowCnxFailed? Column(
                children: [
                   Text('please verify network'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: yellowColHex.withOpacity(0.7),
                  ),),
                  SizedBox(height: 100.h*.1,),

                ],
              ):Container(),

             ///loading
             Padding(
               padding: const EdgeInsets.only(top: 20.0),
               child: Center(
                 child: SizedBox(
                   width: 100.w * .3 ,
                   height: 100.w  * .3 ,
                   child:const LoadingIndicator(
                   indicatorType: Indicator.circleStrokeSpin,
                   colors: [yellowColHex],
                   strokeWidth: 3,
                   ),
                 ),
               ),
             ),

            ],
           ),



        ],
      ),
    );
  }
}
