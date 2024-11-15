import 'package:flutter/material.dart';
import 'package:my_project/models/student_model.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/pages/loading.dart';
import 'package:my_project/pages/login_page.dart';
import 'package:my_project/pages/profile.dart';
import 'package:my_project/pages/register_page.dart';
import 'package:provider/provider.dart';

import 'database/mongo_service.dart';
import 'internet_connection/connectivity_notifier.dart';


Future<void> main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await MongoService.connect();

      runApp(ChangeNotifierProvider(
        create: (context) => Student(),
          child: MaterialApp(
              initialRoute: '/home',
              routes: {
                    '/': (context) => const Loading(),
                '/home': (context) => const ConnectivityNotifier(
                  child: Home(),
                ),
                '/profile': (context) => const Profile(),
                '/log-in': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
              },
          ),
      ),);
}
