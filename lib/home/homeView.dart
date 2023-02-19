import 'dart:ui';
import 'package:beekeeper/_auth/login_screen.dart';
import 'package:beekeeper/addRequest/addRequestView.dart';
import 'package:beekeeper/education/educationView.dart';
import 'package:beekeeper/models/bkUserModel.dart';
import 'package:beekeeper/myPacks/mapVoids.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:beekeeper/notifications/notificationCtr.dart';
import 'package:beekeeper/shop/shopView.dart';
import 'package:beekeeper/transfer/transfert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homeCtr.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCtr gc = Get.find<HomeCtr>();


  BkUser cUser = authCtr.cUser;


  appDrawer() {
    Widget divider(){
      return const Divider(
        height: 10,
        endIndent: 30,
        indent: 30,
      );
    }

    return Drawer(
      width: 100.w * .7,
      child: Column(
        children: <Widget>[
          Expanded(
            // upper listTiles
            child: ListView(
              children: [
                ///header
                Container(
                  color: Color(0XFFe9d98e),
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(3, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: SizedBox(
                              //size: Size.fromRadius(30),
                              child: Image.asset('assets/images/user.png'),
                            ),
                          ),
                        ),

                        /// user name
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text( cUser.name!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: blueColHex)),
                        ),

                        /// user info
                        subtitle: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 3.0),
                              child: Container(
                                width: 100.w * 0.6,
                                child: RichText(
                                  locale: Locale(currLang!),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: cUser.email!,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 3.0),
                              child: Container(
                                width: 100.w * 0.6,
                                child: RichText(
                                  locale: Locale(currLang!),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'عدد العملات: ${authCtr.cUser.coins}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Add your own request
                ListTile(
                  leading: Icon(
                    Icons.add,
                    color: yellowColHex,
                  ),
                  title: Text('Add your request'.tr),
                  onTap: () {
                    Get.back();
                    Get.to(() => AddRequestView());

                  },
                ),
                divider(),
                /// Education
                ListTile(
                  leading: Icon(
                    Icons.menu_book,
                    color: yellowColHex,
                  ),
                  title: Text('education'.tr),
                  onTap: () {
                    Get.back();
                    Get.to(() => Education());

                  },
                ),
                divider(),
                /// shop
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: yellowColHex,
                  ),
                  title: Text('items list'.tr),
                  onTap: () {
                    Get.back();
                    Get.to(() => ShopView());

                  },
                ),
                divider(),
                /// transfer_coins
                ListTile(

                  leading:  Icon(
                    Icons.monetization_on,
                    color: yellowColHex,

                  ),
                  title: Text('Transfer Coins'.tr),
                  onTap: () {
                    Get.back();
                    Get.to(() => Transfert());

                  },
                ),
                divider(),
                /// News
                ListTile(
                  leading: const Icon(
                    Icons.newspaper,
                  ),
                  title: Text('News'.tr),
                  onTap: () {
                    Get.back();
                    //Get.to(() => NewsView());
                  },
                ),
                divider(),
                /// Notifications
                GetBuilder<MyNotifCtr>(
                  //id: 'notif',
                  builder: (ctr) => ListTile(
                    leading: const Icon(
                      Icons.notifications,
                    ),
                    title: Row(
                      children: [
                        SizedBox(
                            width: 100,
                            child: Text('Notifications'.tr,
                              maxLines: 1,
                            )),
                        Switch(
                          inactiveThumbColor: Colors.white54,
                          inactiveTrackColor: Colors.grey[700],
                          value: ctr.isNotifActive,
                          onChanged: (val) {
                            //gc.switchNotif(val);
                            ctr.onSwitch(val);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                divider(),


              ],
            ),
          ),
          // downer listTiles

          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          const Divider(),

                          ///Terms and Policies
                          ListTile(
                            dense: true,

                            leading: const Icon(
                              Icons.policy,
                              //color: Colors.redAccent,
                            ),
                            title: Text(
                              'Terms and Policies'.tr,
                              //style: TextStyle(color: Colors.redAccent),
                            ),
                            onTap: () async {
                              Get.back();

                            },
                          ),
                          const Divider(),
                          ListTile(
                            dense: true,


                            leading: const Icon(
                              Icons.logout,
                              color: Colors.redAccent,
                            ),
                            title: Text(
                              'Sign out'.tr,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  height: 0
                              ),
                            ),
                            onTap: () async {
                              Get.back();
                              authCtr.signOut();
                              Get.offAll(() => LoginScreen());
                            },
                          ),
                        ],
                      ))))
        ],
      ),
    );
  }


  spAppBar() {
    return AppBar(
      toolbarHeight: 60.0,
      /// title
      title: Text('BeeKeeper'.tr),

      /// refresh-search-clearSearch
      actions: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            /// refresh
            IconButton(
              padding: EdgeInsets.only(left: 0.0),
              icon:const Icon(Icons.refresh),
              onPressed: () {
                authCtr.refreshCuser();
                gc.downloadRequestsFromDb();

              },
            ),
            SizedBox(width: 0),
            IconButton(
              padding: EdgeInsets.only(left: 15.0),
              icon:  Icon(Icons.exit_to_app),
              onPressed: () {
                authCtr.signOut();
                Get.offAll(() => LoginScreen());
              },
            ),
          ],
        )

      ],
      /// drawer
      leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.list,
                color: yellowColHex,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              } ,
            );
          }
      ),
      bottom: appBarUnderline(),
    );
  }

  //###################################################################################################################"
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: spAppBar(),
      drawer: appDrawer(),
      body: Stack(
        children: [
          /// map
          GetBuilder<HomeCtr>(
              initState: (_) {


              },
              dispose: (_) {
                //print('## home_View');
                //Get.delete<HomeCtr>();
              },

              id: 'map',
              builder: (_) {
                // Future.delayed(const Duration(milliseconds: 70), () {
                //   gc.updateMap();
                // });
                //print('## map updated');
                return CustomGoogleMapMarkerBuilder(

                  screenshotDelay: Duration(seconds: 1),// add loading time
                  customMarkers: mapToListMarkerData(gc.rqMarkers),
                  builder: (BuildContext context, Set<Marker>? markers) {
                    return Stack(
                      children: [
                        /// map
                        GoogleMap(
                            mapType: MapType.normal,
                            markers: markers ?? {},
                            initialCameraPosition: (gc.userPos.latitude * gc.userPos.latitude != 0.0)
                                ? CameraPosition(
                                    target: LatLng(gc.userPos.latitude, gc.userPos.longitude),
                                    zoom: 10,)
                                : susahPos,
                            mapToolbarEnabled: false,
                            trafficEnabled: false,
                            liteModeEnabled: false,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> {
                           Factory<OneSequenceGestureRecognizer>(()=>EagerGestureRecognizer()),
                          },
                            onMapCreated: (controller) async {
                              gc.onMapCreated(controller);
                            }),
                        /// loading markers
                        if(markers == null)
                          const Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 70.0),
                                child: CircularProgressIndicator(),
                              ))
                      ],
                    );
                  },
                );
              }),


          /// gps btn
          Positioned(
            height: 60,
            width: 60,
            bottom: 10,
            left: 10,
            child: FloatingActionButton.extended(
              backgroundColor: blueColHex,
              heroTag: 'gpsBtn',
              onPressed: () async {
                gc.userPos = await getCurrentLocation(gc.gMapCtr,moveCamToUser: true);
              },
              label: const Icon(
                Icons.gps_fixed,
                color: yellowColHex,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
