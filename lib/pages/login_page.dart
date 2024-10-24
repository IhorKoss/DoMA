import 'package:flutter/material.dart';
import 'package:my_project/validators/validators.dart';
import 'package:my_project/widgets/custom_form_button.dart';
import 'package:my_project/widgets/input_custom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                       validator: Validators.studentId,
                       hintText: 'Номер студ. квитка',
                     ),
                     const SizedBox(height: 15),
                     TextInput(
                       validator: Validators.password,
                       hintText: 'Пароль',
                     ),
                     const SizedBox(height: 15),
                     CustomFormButton(
                       onTap: (){
                         if (formKey.currentState!.validate()) {
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
