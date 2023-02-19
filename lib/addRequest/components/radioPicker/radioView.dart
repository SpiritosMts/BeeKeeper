import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'radioCtr.dart';



class PickRadiosView extends StatelessWidget {
  final RadioPickerCtr gc = Get.find<RadioPickerCtr>();



  @override
  Widget build(BuildContext context) {
    return GetBuilder<RadioPickerCtr>(
        builder: (ctr) => Column(
          children: [
            SizedBox(
              width: double.infinity,

              child: Container(
                padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:  Text(
                  textAlign: TextAlign.start,
                  'nest type'.tr,
                  style:const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // job_picker
            Column(
              children: <Widget>[
                ListTile(
                  title:  Text('hornets net'.tr),
                  leading: Radio(
                    groupValue: gc.selectedType,
                    value:'hornets net',
                    onChanged: (value) {
                      gc.changeType(value);
                    },
                  ),
                ),
                ListTile(
                  title:  Text('Random beehive'.tr),
                  leading: Radio(
                    groupValue: gc.selectedType,
                    value:'Random beehive',
                    onChanged: (value) {
                      gc.changeType(value);
                    },
                  ),
                ),
                ListTile(
                  title:  Text('A beehive has a breeder'.tr),
                  leading: Radio(
                    groupValue: gc.selectedType,
                    value:'A beehive has a breeder',
                    onChanged: (value) {
                      gc.changeType(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

          ],
        ));
  }
}
