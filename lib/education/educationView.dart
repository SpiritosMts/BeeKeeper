import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          scrollDirection: Axis.horizontal,

          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 20,right: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text("education".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

                    SizedBox(height: 40,),

                    Row(children: [
                      Container(
                          height: 150,
                          width: 150,
                          child: Image(image: NetworkImage("https://scontent.ftun10-1.fna.fbcdn.net/v/t1.15752-9/327008538_744270990358559_6138457685841706152_n.png?_nc_cat=100&ccb=1-7&_nc_sid=ae9488&_nc_ohc=SHik2nt2ZkoAX_xvUhi&_nc_ht=scontent.ftun10-1.fna&oh=03_AdQBTuJFKT04mvdrN6GihEqEN4PAcUfS_NfTgDhOwyJ0ow&oe=64192256"))),
                      SizedBox(width: 40,),
                      Text("الشعر :يمتلك النحل \nأجسامًا مشعرة، بينما الدبابير ليس لها\n شعر تقريبًا. من ناحية أخرى ، فإن \nالدبابير أكثر شعرًا من الدبابير.")

                    ],),
                    SizedBox(height: 25,),

                    Row(children: [


                      Text("اللون :الدبور والنحلة مخططان ولون \nأسودوأصفر ولكن ألوان الدبور\n أكثر إشراقًا.الدبابير له\n جسم برتقالي أكثر من الدبور.\n الدبابير ذات الأرجل الصفراء\n (الدبور الآسيوي) أغمق من الدبور \nالأوروبي مع صدر بني وأسود و\nحلقة برتقالية كبيرة على البطن"),
                      SizedBox(width: 40,),
                      Container(
                          height: 150,
                          width: 150,
                          child: Image(image: NetworkImage("https://scontent.ftun10-1.fna.fbcdn.net/v/t1.15752-9/326904360_1243239936609599_2534600719394987402_n.png?_nc_cat=107&ccb=1-7&_nc_sid=ae9488&_nc_ohc=YY9OKclOEjkAX8vspTN&_nc_ht=scontent.ftun10-1.fna&oh=03_AdQFdk7IogQ-Jp2HNmtkKg1lhUWNPojCqZqLtkgJ22moqw&oe=64191A6F"))),

                    ],),
                    SizedBox(height: 25,),

                    Row(children: [
                      Container(
                          height: 150,
                          width: 150,
                          child: Image(image: NetworkImage("https://img.icons8.com/external-goofy-color-kerismaker/256/external-Bee-farming-goofy-color-kerismaker.png"))),
                      SizedBox(width: 40,),
                      Text("طعام:رحيق الزهور \nهو الغذاء الوحيد للنحل ، على عكس الدبابير \nالتي تتغذى أيضًا على الحشرات ، والفاكهة\n الناضجة ، والنسغ ، وما إلى ذلك\n.تتغذى الزنابير (الأوروبية أو الآسيوية) \nعلى الحشرات: الذباب ، الدبابير ،\n اليرقات ، الفراشات أو العث ، الجنادب \n، الجراد ...الدبابير الآسيوية لها \nخصوصية التغذية بالإضافة إلى النحل.")

                    ],),
                    SizedBox(height: 25,),

                    Row(children: [


                      Text("العش :عش النحل مصنوع من \nالشمع ، وعش الدبابير مصنوع من\n ألياف الخشب.يحتوي عش الدبابير على \nغلاف من مادة تشبه الورق وغالبًا\n ما يتم العثور عليه عالياً.يقع \nعش الدبابير بالقرب من الأرض."),
                      SizedBox(width: 40,),
                      Container(
                          height: 150,
                          width: 150,
                          child: Image(image: NetworkImage("https://img.icons8.com/external-flatart-icons-lineal-color-flatarticons/256/external-bee-agriculture-flatart-icons-lineal-color-flatarticons.png"))),

                    ],),
                    SizedBox(height: 25,),

                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
