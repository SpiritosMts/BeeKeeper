import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'mapCtr.dart';

class PickMapView extends StatelessWidget {
  final MapPickerCtr getCtrl = Get.find<MapPickerCtr>();


  @override
  Widget build(BuildContext context) {
    return    GetBuilder<MapPickerCtr>(
        builder: (ctr) => Row(children: [

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:  Text(
              'choose location'.tr,
              style:const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /// marker button
          Center(
            child: Ink(
              decoration: const ShapeDecoration(
                color: yellowColHex,
                shape: CircleBorder(),
              ),
              child: IconButton(

                style: ButtonStyle(

                ),
                // focusColor: blueColHex2,
                // highlightColor: blueColHex2,
                // hoverColor: blueColHex2,
                // splashColor: blueColHex2,
                // disabledColor: blueColHex2,
                icon: const Icon(Icons.place_rounded),
                color: blueColHex2,
                onPressed: () {
                  fieldUnfocusAll();
                  getCtrl.pushMarkerScreen(context);
                },
              ),
            ),
          ),
          //Text('Lat: ${getCtrl.lati}\nLng: ${getCtrl.lngi}\n'),


        ]),
    );
  }
}
