import 'package:flutter/material.dart';
import 'package:my_project/classes/home_menu_btn_class.dart';
import 'package:my_project/database/storage_service.dart';
import 'package:my_project/models/student_model.dart';
import 'package:my_project/widgets/home_menu_btn.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Map<String, dynamic>?> _loggedStudentFuture;

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
  void initState() {
    super.initState();
    _loggedStudentFuture = LocalStorageService.getLoggedStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    IconButton(
                      icon: Icon(
                        Icons.account_box,
                        size: 40,
                        color: Colors.indigo[900],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
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
                        FutureBuilder<Map<String, dynamic>?>(
                          future: _loggedStudentFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Помилка: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(child: Text('Ви не авторизовані', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              )));
                            } else {
                              final studentData = snapshot.data!;
                              final student = Student.fromJson(studentData);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.fullName.isNotEmpty ? student.fullName : 'Завершіть реєстрацію у профілі',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  ),
                                  Text(
                                    student.studentId,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  Text(
                                    student.isFullTimeStudent ? 'Денна форма навчання' : 'Заочна форма навчання',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  if (student.group.isNotEmpty)
                                    Text(
                                      student.group,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: homeBtnList.map((homeBtn) => HomeMenuBtn(homeMenuBtnData: homeBtn)).toList(),
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
