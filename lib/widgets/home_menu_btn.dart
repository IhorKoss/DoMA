import 'package:flutter/material.dart';
import 'package:my_project/classes/home_menu_btn_class.dart';

class HomeMenuBtn extends StatelessWidget {
  final HomeMenuBtnClass homeMenuBtnData;
  const HomeMenuBtn({required this.homeMenuBtnData, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('tapped');
      },
      child: Column(
        children:[ DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(homeMenuBtnData.header,
                        style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                      Text(homeMenuBtnData.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,),),
                    ],
                  ),
                ),
                Image(image: AssetImage(homeMenuBtnData.imageLink),width: 90,),
              ],
            ),
          ),
        ),
          const SizedBox(height: 20),
      ],),
    );
  }
}
