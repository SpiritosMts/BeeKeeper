import 'package:beekeeper/addRequest/addRequestCtr.dart';
import 'package:beekeeper/addRequest/components/imagePicker/imageView.dart';
import 'package:beekeeper/addRequest/components/mapNoAddrPicker/mapView.dart';
import 'package:beekeeper/addRequest/components/radioPicker/radioView.dart';
import 'package:beekeeper/addRequest/components/textFields/fieldsView.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class AddRequestView extends StatelessWidget {

  final AddRequestCtr gc = Get.find<AddRequestCtr>();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => fieldUnfocusAll(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Add your own request'.tr),
            bottom: appBarUnderline(),
          ),
          body: GetBuilder<AddRequestCtr>(
            builder: (ctr) => SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldsView(),
                  ylwDivider(),
                  PickRadiosView(),
                  ylwDivider(),
                  PickMapView(),
                  ylwDivider(),
                  PickImagesView(),
                  ylwDivider(),

                  ///add
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      fieldUnfocusAll();
                      gc.addRequest(context);
                    },
                    child: Text(
                      'Add'.tr,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
