
import 'package:beekeeper/home/homeCtr.dart';
import 'package:beekeeper/models/requestModel.dart';
import 'package:beekeeper/myPacks/mapVoids.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/myPacks/scrollingImages.dart';
import 'package:beekeeper/myPacks/storeComponents/storeVoids.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedRqView extends StatefulWidget {
  @override
  State<SelectedRqView> createState() => _SelectedRqViewState();
}

class _SelectedRqViewState extends State<SelectedRqView> with TickerProviderStateMixin {


  Requestb rq = Requestb();

  headerLogo(Requestb rq) {
    double containerSize = 110.0;
    double borderWidth = 1.0;
    return Stack(
      //alignment: Alignment.bottomCenter,

      children: [

        /// head_job_logo
        Positioned(
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              color: yellowColHex.withOpacity(.3),
              borderRadius: BorderRadius.circular(90),
              border: Border.all(color: yellowColHex, width: borderWidth, style: BorderStyle.solid),
            ),
            child: Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: CircleAvatar(
                radius: 80.0,
                backgroundColor: blueColHex,
                child: Image.asset('assets/images/ran.png'),
                // foregroundImage: ( gc.st.logo! != '' && showMarkerLogo)? NetworkImage( gc.st.logo!):jobTypeIcon(gc.st.jobType!),
              ),
            ),
          ),
        ),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        child: GetBuilder<HomeCtr>(
          initState: (_) {
            rq = Get.find<HomeCtr>().selectedRq;

            print('## open SelectedRq View');
          },
          dispose: (_) {
            print('## close SelectedRq View');
          },
          builder: (ctr) => SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  // height: MediaQuery.of(context).size.height * gc.dialogheightScale,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),

                        ///logo
                        headerLogo(rq),

                        /// name
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ///name
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    '${rq.name}',
                                    style: GoogleFonts.almarai(fontSize: 30, height: 1.3),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        /// schedule-directions-call
                        Container(
                          padding: const EdgeInsets.only(right: 20.0, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              ///directions
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 0.0),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: blueColHex,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: yellowColHex, width: 1, style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(100)),
                                      ),
                                      onPressed: () async {
                                        await openGoogleMapApp(rq.latitude!, rq.longitude!);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.subdirectory_arrow_left_rounded,
                                              color: yellowColHex,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "directions".tr,
                                              style: const TextStyle(color: yellowColHex, fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ///call
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  height: 35,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 0.0),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: blueColHex,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: yellowColHex, width: 1, style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(100)),
                                      ),
                                      onPressed: () async {
                                        launchUrl(Uri.parse("tel://${rq.phone}"));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              color: yellowColHex,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "call".tr,
                                              style: const TextStyle(color: yellowColHex, fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),


                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),

                            /// store_images
                            rq.images!.isNotEmpty ? ImagesScroll(imageList: rq.images!) : Container(),
                            const SizedBox(
                              height: 15,
                            ),

                            ///name
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.person,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Container(
                                    //padding: const EdgeInsets.only(right:25.0),
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: RichText(
                                      locale: Locale(currLang!),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '${rq.name}',
                                          style: const TextStyle(
                                            height: 1.5,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ///email
                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.alternate_email,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Container(
                                    //padding: const EdgeInsets.only(right:25.0),
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: RichText(
                                      locale: Locale(currLang!),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '${rq.email}',
                                          style: const TextStyle(
                                            height: 1.5,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),


                            ///full_adress
                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.place,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Container(
                                    //padding: const EdgeInsets.only(right:25.0),
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: RichText(
                                      locale: Locale(currLang!),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '${rq.address}',
                                          style: const TextStyle(
                                            height: 1.5,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ///desc
                            if (rq.desc != '')
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    Icons.description,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Container(
                                      //padding: const EdgeInsets.only(right:25.0),
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: RichText(
                                        locale: Locale(currLang!),
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: '${rq.desc}',
                                            style: const TextStyle(
                                              height: 1.5,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 15,
                            ),



                          ],
                        ),


                        const SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  ),
                ),



                /// back_btn
                Positioned(
                  top: 5,
                  right: 5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 30,
                          height: 30,
                          color: blueColHex,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: yellowColHex,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),

                ///approve btn
                (rq.accepted == 'notYet')
                    ? Positioned(
                  height: 40,
                  width: 110,
                  bottom: 19,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        shape: RoundedRectangleBorder(
                          //side: const BorderSide(color: blueColHex, width: 2, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () async {
                        approveRequest(rq.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check,
                            color: blueColHex,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Approve".tr,
                            style: const TextStyle(color: blueColHex),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
