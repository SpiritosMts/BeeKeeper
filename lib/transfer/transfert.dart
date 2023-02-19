import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transfert extends StatefulWidget {
  const Transfert({super.key});

  @override
  State<Transfert> createState() => _TransfertState();
}

class _TransfertState extends State<Transfert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Transfer Coins".tr),             bottom: appBarUnderline()),
        body: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 200),
                        decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 50)]),
                        child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Color.fromARGB(255, 72, 62, 62),
                            child: Text('نقاط', style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 200),
                        child: Icon(Icons.arrow_forward, size: 50),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, top: 200),
                        decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 50)]),
                        child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Color.fromARGB(255, 72, 62, 62),
                            child: Text(
                              'دينار التونسي',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(),
                      hintText: 'نقاط',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("تحويل مالي "),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration:
                        InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10), border: OutlineInputBorder(), hintText: 'دينار التونسي'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
