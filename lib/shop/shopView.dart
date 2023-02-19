import 'package:beekeeper/models/itemModel.dart';
import 'package:beekeeper/myPacks/myTheme/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  Widget itemCard(Item item) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          color: blueColHex2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Row(
            children: <Widget>[
              Container(
                //width: 150,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        item.name!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${item.price!} د',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 9.5, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("shop now".tr,
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Text(
                            "Ratings".tr,
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 7, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.orangeAccent,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.orangeAccent,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.orangeAccent,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.orangeAccent,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 90,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    fit: BoxFit.cover,
                    alignment: Alignment.topRight,
                    image: NetworkImage(item.imageUrl!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Item> itemsList = [
    Item(
      name: 'مبيد للدبابير',
      desc:
          'تخلص من الدبابير والدبابير ودبابير السترة الصفراء مرة واحدة وإلى الأبد. يمكن استخدام مبيد الحشرات الهوائي الجاهز للاستخدام وسهل الاستخدام حتى 6 أمتار (20 قدمًا).',
      price: '10.99',
      newPrice: '5.99',
      imageUrl: 'https://pestcontrolcairo.com/wp-content/uploads/2022/08/DSC_4016.jpg',
    ),
    Item(
      name: 'صائد دبابير',
      desc:'يسمح هذا المصيدة البيئية البسيطة للغاية بالتقاط الحشرات، التي تنجذب داخل المصيدة برائحة سائل (مثل الحليب أو الشراب) التي سيتم تقديمها سابقًا.',
      price: '7.99',
      newPrice: '5.99',
      imageUrl: 'https://ae01.alicdn.com/kf/Hffffcf815b7b44df81e38583db7f5d5ar.jpg',
    ),
    Item(
      name: 'نبتة النعناع',
      desc: 'من النباتات التي تزعج روائحها الدبابير وحشرات أخرى مماثلة.',
      price: '0.99',
      newPrice: '0.49',
      imageUrl: 'https://www.sayidaty.net/sites/default/files/imce/user335386/n_4.jpg',
    ),
    Item(
      name: 'شباك الحماية',
      desc: 'هذه الشباك تسمح بمرور النحل إلى الخلية وتمنع وصول الدبابير إليها.',
      price: '1.99',
      newPrice: '0.99',
      imageUrl: 'https://scontent.ftun10-1.fna.fbcdn.net/v/t1.15752-9/328317957_728369758680362_2263994661270283444_n.png?_nc_cat=105&ccb=1-7&_nc_sid=ae9488&_nc_ohc=bU404l_rk2IAX9ZoHVq&_nc_ht=scontent.ftun10-1.fna&oh=03_AdTAguOf6TGwId9FLy1GIhaIdEUwxa_HPqLEAlOc2MOj-A&oe=64193A44',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("items list".tr),
        bottom: appBarUnderline(),

      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            itemCard(itemsList[0]),
            itemCard(itemsList[1]),
            itemCard(itemsList[2]),
            itemCard(itemsList[3]),
          ],
        ),
      ),
    );
  }
}
