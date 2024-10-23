import 'package:flutter/material.dart';

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
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.blue[900],
          title: const Text(
            'Профіль користувача',
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
          ),
        ),
    );
  }
}
