import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  final bool isSuccess;

  const LoginDialog({Key? key, required this.isSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isSuccess ? 'З поверненням!' : 'Ой :(',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),),
      content: Text(isSuccess
          ? 'Ви успішно авторизувались'
          : 'Вхід не успішний. Неправильний логін або пароль',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  static void show(BuildContext context, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog(isSuccess: isSuccess);
      },
    );
  }
}
