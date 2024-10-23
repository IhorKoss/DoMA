import 'package:flutter/material.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/pages/loading.dart';
import 'package:my_project/pages/login_page.dart';
import 'package:my_project/pages/profile.dart';
import 'package:my_project/pages/register_page.dart';

void main() => runApp(MaterialApp(

    initialRoute: '/home',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => const Home(),
      '/profile': (context) => const Profile(),
      '/log-in': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
    }
));