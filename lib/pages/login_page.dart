
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_project/database/mongo_service.dart';
import 'package:my_project/models/student_model.dart';
import 'package:my_project/validators/validators.dart';
import 'package:my_project/widgets/custom_form_button.dart';
import 'package:my_project/widgets/input_custom.dart';
import 'package:my_project/widgets/loggingDialogWindow.dart';
import 'package:provider/provider.dart';

import '../widgets/no_interned_dialog.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<bool> _checkInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      NoInternetDialog.show(context);
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? password;
    String? email;
    return  Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.blue[900],
          title: const Text(
            'Увійти в акаунт',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,),),
          centerTitle: true,
          elevation: 0,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                key: formKey,
                child:
                 Column(
                   children: [
                     const Image(image: AssetImage('assets/images/ep_logo.png'), width: 400,),
                     const SizedBox(height: 15),
                     TextInput(
                       validator: Validators.email,
                       hintText: 'Електронна пошта',
                       onChanged: (value) {
                         email = value.toString();
                       },
                     ),
                     const SizedBox(height: 15),
                     TextInput(
                       validator: Validators.password,
                       hintText: 'Пароль',
                       obscureText: true,
                       onChanged: (value) {
                         password = value.toString();
                       },
                     ),
                     const SizedBox(height: 15),
                     CustomFormButton(
                       onTap: () async {
                         if (await _checkInternetConnection(context)) {
                           if (formKey.currentState!.validate()) {
                             final loggingStudent = await MongoService.getStudentByEmail(email!);
                             if (loggingStudent != null) {
                               if (loggingStudent['password'] == password) {
                                 Provider.of<Student>(context, listen: false).setLoggedInStudent(
                                     email: loggingStudent['email'] as String,
                                     password: loggingStudent['password'] as String,
                                     studentId: loggingStudent['studentId'] as String,
                                     fullName: loggingStudent['fullName'] != null ? loggingStudent['fullName'] as String:'',
                                     group: loggingStudent['group'] != null ? loggingStudent['group'] as String : '',
                                     isFullTimeStudent: loggingStudent['isFullTimeStudent']!=null ? loggingStudent['isFullTimeStudent'] as bool:true,
                                 );
                                 Navigator.pushNamed(context, '/home');
                                 LoginDialog.show(context, true);
                                 await MongoService.loggedStudent(loggingStudent);
                               }else {
                                 LoginDialog.show(context, false);
                               }
                             }else {
                               LoginDialog.show(context, false);
                             }
                           }
                         }
                       },
                       buttonText: 'Увійти',
                     ),
                     InkWell(
                       child: Text(
                         'Немає аккаунту? Зареєструйтесь',
                         style: TextStyle(
                             color: Colors.blue[900],
                             fontSize: 16,
                             decoration: TextDecoration.underline,
                             decorationColor: Colors.blue[900],
                         ),
                       ),
                       onTap: () => Navigator.pushNamed(context, '/register'),
                     ),
                   ],

              ),
              ),
              const Image(image: AssetImage('assets/images/nulp_logo.png'), width: 200,),
            ],
          ),
        ),
    );
  }
}
