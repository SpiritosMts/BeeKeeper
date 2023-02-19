import 'dart:io';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:beekeeper/myPacks/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'imageCtr.dart';

class PickImagesView extends StatelessWidget {
  final ImagePickerCtr gc = Get.find<ImagePickerCtr>();

  // @override
  // void dispose() {
  //   Get.delete<ImagePickerCtr>();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerCtr>(
        builder: (ctr) => Column(
              children: [

                /// browse_images
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        'Images'.tr,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: TextButton(
                        style: ylwStyle,
                        onPressed: () async {
                          PickedFile img = await showImageChoiceDialog();
                          gc.updateImages(img);
                        },
                        child: Text(
                          "Add".tr,
                          style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),

                /// images_list
                (gc.imageFileList!.isNotEmpty)
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 0.0, top: 0.0),
                            child: SizedBox(
                              height: 100,
                              child: Container(
                                child: (gc.imageFileList!.isNotEmpty )
                                    ? ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: gc.imageFileList!.length ,
                                        itemBuilder: (context, index) {
                                          return gc.singleImage(gc.imageFileList!, index);

                                        })
                                    : Center(
                                        child: Text('no chosen images'.tr),
                                      ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ));
  }
}
