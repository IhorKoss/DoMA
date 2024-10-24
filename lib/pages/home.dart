import 'package:flutter/material.dart';
import 'package:my_project/classes/home_menu_btn_class.dart';
import 'package:my_project/widgets/home_menu_btn.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<HomeMenuBtnClass> homeBtnList = [
    HomeMenuBtnClass(
      header: 'Розклад занять',
      description: 'Переглядай свій розклад занять та актуальні зміни в ньому.',
      imageLink: 'assets/images/ep_small.png',
    ),
    HomeMenuBtnClass(
      header: 'Електронна бібліотека',
      description: 'Доступ до електронних ресурсів та підручників університету.',
      imageLink: 'assets/images/ep_small.png',
    ),
    HomeMenuBtnClass(
      header: 'Студентські заяви',
      description: 'Подавай електронні заяви на стипендію, відпустку чи інші потреби.',
      imageLink: 'assets/images/ep_small.png',
    ),
    HomeMenuBtnClass(
      header: 'Рейтинг успішності',
      description: 'Перевіряй свій рейтинг і досягнення протягом навчального року.',
      imageLink: 'assets/images/ep_small.png',
    ),
    HomeMenuBtnClass(
      header: 'Новини університету',
      description: 'Будь в курсі останніх новин та подій, що відбуваються в університеті.',
      imageLink: 'assets/images/ep_small.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[300]!, Colors.purple[300]!],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Image(image: AssetImage('assets/images/ep_logo.png'), width: 150,),
                      IconButton(icon:Icon(Icons.account_box,
                          size: 40,color:Colors.indigo[900],),
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },),
                    ],
                  ),
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey[100]?.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: ListView(

                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Кос Ігор Іванович',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                              Text(
                                'ВК0000000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                'Денна форма навчання',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Група: КБ-406',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 20,
                            thickness: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children:homeBtnList.map((homeBtn) => HomeMenuBtn(homeMenuBtnData: homeBtn)).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
