
import 'package:beekeeper/models/itemModel.dart';
import 'package:get/get.dart';

class ShopCtr extends GetxController{

 Item selectedItem = Item();
 selectItem(Item item){
   selectedItem = item;
 }
}