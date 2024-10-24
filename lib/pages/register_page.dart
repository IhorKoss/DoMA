import 'package:flutter/material.dart';

import 'package:my_project/widgets/custom_form_button.dart';
import 'package:my_project/widgets/input_custom.dart';

import '../validators/validators.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  String? password;
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
                        ),
                        const SizedBox(height: 15),
                        TextInput(
                          validator: Validators.email,
                          hintText: 'Електронна пошта',
                        ),
                        const SizedBox(height: 15),
                        TextInput(
                          validator: Validators.password,
                          hintText: 'Пароль',
                          obscureText: true,
                          onChanged: (value) {
                              password = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextInput(
                          validator: (value) {
                            if (value != password) {
                              print(value);
                              print(password);
                              return 'Паролі не співпадають';
                            }
                            return null;
                          },
                          obscureText: true,
                          hintText: 'Підтвердити пароль',
                        ),
                        const SizedBox(height: 15),
                        CustomFormButton(
                          onTap: (){
                            if (formKey.currentState!.validate()) {
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
