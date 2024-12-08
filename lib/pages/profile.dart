import 'package:flutter/material.dart';
import 'package:ihor_flashlight_plugin/ihor_flashlight_plugin.dart';
import 'package:my_project/database/student_service.dart';
import 'package:provider/provider.dart';

import '../database/storage_service.dart';
import '../models/student_model.dart';
import '../widgets/logout_dialog_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // change your color here
        ),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Профіль користувача',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              bool? shouldLogout = await LogoutDialog.show(context);
              if (shouldLogout == true) {
                await LocalStorageService.clearLoggedStudent();
                Provider.of<Student>(context, listen: false).logOutStudent();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ви вийшли з аккаунту. Повертайтеся чимскоріш!'),
                  ),
                );
                Navigator.pushNamed(context, '/home');
              }
            },
            color: Colors.white,
          ),
        ],
      ),
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
          child: Consumer<Student>(
            builder: (context, student, child){
              if(student.hasData){
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (student.fullName.isNotEmpty)
                            const SmallDescription(text: 'ПІБ'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    student.fullName.isNotEmpty
                                        ? student.fullName
                                        : 'Додайте імя та інші дані :)',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final TextEditingController fullNameController = TextEditingController(text: student.fullName);
                                      return CustomEditDialog(
                                          title: 'Редагувати ПІБ',
                                          controller: fullNameController,
                                          hintText: 'Введіть ваш ПІБ',
                                          onSave: ()async{
                                            if(fullNameController.text.isNotEmpty){
                                              final Map<String, dynamic> updatedData = {
                                                'fullName': fullNameController.text,
                                              };
                                              await StudentService.updateStudentById(student.id,updatedData);
                                              Provider.of<Student>(context, listen: false).setFullName(fullNameController.text);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SmallDescription(text: 'Номер студ. квитка'),
                          Text(
                            student.studentId,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SmallDescription(text: 'Форма навчання'),
                          Text(
                              student.isFullTimeStudent ? 'Денна' : 'Заочна',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                          ),
                          const SmallDescription(text: 'Email'),
                          Text(
                              student.email,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                          ),
                          const SmallDescription(text: 'Група'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    student.group.isNotEmpty
                                        ? student.group
                                        : 'Не вказано',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final TextEditingController groupController = TextEditingController(text: student.group);
                                      return CustomEditDialog(
                                        title: 'Редагувати номер групи',
                                        controller: groupController,
                                        hintText: 'Введіть вашу групу',
                                        onSave: ()async{
                                          if(groupController.text.isNotEmpty){
                                            final Map<String, dynamic> updatedData = {
                                              'group': groupController.text,
                                            };
                                            await StudentService.updateStudentById(student.id,updatedData);
                                            Provider.of<Student>(context, listen: false).setGroup(groupController.text);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text('Секретна функція :)',
                                style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),),
                              IconButton(
                                iconSize: 35,
                                icon: Icon(
                                  IhorFlashlightPlugin.isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
                                  color: IhorFlashlightPlugin.isFlashlightOn ? Colors.black : Colors.black,
                                ),
                                onPressed: () async {
                                  if (IhorFlashlightPlugin.isFlashlightOn) {
                                    await IhorFlashlightPlugin.offLight();
                                  } else {
                                    await IhorFlashlightPlugin.onLight();
                                  }
                                  setState(() {});
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ви не авторизувались :(',style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                    InkWell(
                      child: Text(
                        'Увійти',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue[900],
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/log-in'),
                    ),
                    InkWell(
                      child: Text(
                        'Зареєструватись',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue[900],
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/register'),
                    ),
                  ],
                );
              }
            },
        ),
    ),);
  }
}

class SmallDescription extends StatelessWidget {
  final String text;

  const SmallDescription({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }
}
class CustomEditDialog extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;

  const CustomEditDialog({
    required this.title,
    required this.controller,
    required this.hintText,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Скасувати',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text(
            'Зберегти',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
