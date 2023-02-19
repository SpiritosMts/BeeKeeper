
import 'package:beekeeper/models/requestModel.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

logoImage(String type){



  double markerIconSize = 30.0;
  double markerJobIconSize = 23.0;

  String jobIconPath = 'assets/images/ok';
  switch (type) {
      case "hornets net":
        jobIconPath = 'assets/images/hor.png';
        break;
      case "Random beehive":
        jobIconPath = 'assets/images/ran.png';
        break;
      default:
        jobIconPath = 'assets/images/ok.png';
    }
 return Stack(
    alignment: Alignment.center,
    children: [
      ClipRRect(      // bg
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          height: markerIconSize,
          width: markerIconSize,
          color: blueColHex2,
        ),
      ),
      ClipRRect(// job_icon
        borderRadius: BorderRadius.circular(50.0),
        child: Image.asset(
          jobIconPath,
          color:   yellowColHex,
          height: markerJobIconSize,
          width: markerJobIconSize,
        ),
      ),
    ],
  );

}
/// Requestb_marker on map
customMarkerImg(Requestb rq) {
  double markerH = 35.0;
  return Container(
    //height: 100,
    //color: Colors.red.withOpacity(0.4),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        ///Requestb_marker
        Stack(
          alignment: Alignment.center,
          children: [
            /// marker
            Container(
              height: markerH.sp,
              child: FittedBox(
                child: Icon(
                  Icons.add_location,
                  color:  rq.accepted! == 'yes' ? yellowColHex : Colors.redAccent,
                  //size: ,
                ),
              ),
            ),
            /// image
            Positioned(
              //left: markerH * 0.46,
              top: markerH * 0.25,
              child: logoImage(rq.type!),
            ),

          ],
        ),

      ],
    ),
  );
}
