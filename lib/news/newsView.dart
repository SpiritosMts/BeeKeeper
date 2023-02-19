
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewsView extends StatefulWidget {
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> with TickerProviderStateMixin {

  late TabController _tcontroller;
  final List<String> titleList = [
    "Posts".tr,
    "Videos".tr,
  ];
  bool showButtons =false;

  String currentTitle = 'News'.tr;

  @override
  void initState() {
    super.initState();

    currentTitle = titleList[0];
    _tcontroller = TabController(length: 2, vsync: this);
    _tcontroller.addListener(changeTitle); // Registering listener
  }
  @override
  void dispose() {
    _tcontroller.dispose();
    super.dispose();
  }
  void changeTitle() {
    setState(() {
      currentTitle = titleList[_tcontroller.index];
    });
  }




  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            unselectedLabelColor: hintYellowColHex,
            labelColor: yellowColHex,
            controller: _tcontroller,
            isScrollable: false,
            indicatorColor: yellowColHex,
            indicatorWeight: 4,
            tabs:  [
              Tab(icon:Text(titleList[0])),
              Tab(icon:Text(titleList[1])),
            ],
          ),
          title: Text(currentTitle),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tcontroller,
          children: [
            /// posts screen
            SafeArea(
              child:  SingleChildScrollView(
                child: Column(children: [

                ]),
              )
            ),

            /// videos screen
            SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  ///add video btn


                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
