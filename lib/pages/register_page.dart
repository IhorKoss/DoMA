import 'package:flutter/material.dart';

import 'package:my_project/widgets/custom_form_button.dart';
import 'package:my_project/widgets/input_custom.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                child:
                Column(
                  children: [
                    const Image(image: AssetImage('assets/images/ep_logo.png'), width: 400,),
                    const SizedBox(height: 15),
                    TextInput(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Це поле не може бути порожнім';
                        }
                        return null;
                      },
                      hintText: 'Номер студ. квитка',
                    ),
                    const SizedBox(height: 15),
                    TextInput(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Це поле не може бути порожнім';
                        }
                        return null;
                      },
                      hintText: 'Електронна пошта',
                    ),
                    const SizedBox(height: 15),
                    TextInput(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Це поле не може бути порожнім';
                        }
                        return null;
                      },
                      hintText: 'Пароль',
                    ),
                    const SizedBox(height: 15),
                    TextInput(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Це поле не може бути порожнім';
                        }
                        return null;
                      },
                      hintText: 'Підтвердити пароль',
                    ),
                    const SizedBox(height: 15),
                    const CustomFormButton(
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
    );
  }
}
