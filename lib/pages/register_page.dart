import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:my_project/widgets/custom_form_button.dart';
import 'package:my_project/widgets/input_custom.dart';
import 'package:provider/provider.dart';

import 'package:my_project/models/student_model.dart';
import 'package:my_project/validators/validators.dart';

import '../database/auth_service.dart';
import '../database/storage_service.dart';
import '../widgets/no_interned_dialog.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
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
    String? studentId;
    String? email;
    return  Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.blue[900],
          title: const Text(
            'Реєстрація',
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
          child: Center(
            child: SingleChildScrollView(
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
                          validator: Validators.studentId,
                          hintText: 'Номер студ. квитка',
                          onChanged: (value) {
                            studentId = value.toString();
                          },
                        ),
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
                        TextInput(
                          validator: (value) {
                            if (value != password) {
                              return 'Паролі не співпадають';
                            }
                            return null;
                          },
                          obscureText: true,
                          hintText: 'Підтвердити пароль',
                        ),
                        const SizedBox(height: 15),
                        CustomFormButton(
                          onTap: () async {
                            if (await _checkInternetConnection(context)) {
                              if (formKey.currentState!.validate()) {
                                final registered_student = await AuthService.register(email!, password!, studentId!);
                                Provider.of<Student>(context, listen: false).setNewStudent(
                                    id: registered_student['_id'] as String,
                                    email: email as String,
                                    password: password as String,
                                    studentId: studentId as String,);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Реєстрація успішна!'),
                                  ),
                                );
                                Navigator.pushNamed(context, '/home');
                                await LocalStorageService.saveLoggedStudent(registered_student);
                              }
                            }
                          },
                          buttonText: 'Зареєструватись',
                        ),
                        InkWell(
                          child: Text(
                            'Вже є акаунт? Увійдіть!',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue[900],
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(context, '/log-in'),
                        ),
                      ],
              
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
