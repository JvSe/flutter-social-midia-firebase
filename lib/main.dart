import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_midia_firebase/auth/auth.dart';
import 'package:social_midia_firebase/auth/login_or_register.dart';
import 'package:social_midia_firebase/firebase_options.dart';
import 'package:social_midia_firebase/pages/home_page.dart';
import 'package:social_midia_firebase/pages/profile_page.dart';
import 'package:social_midia_firebase/pages/users_page.dart';
import 'package:social_midia_firebase/theme/dark_mode.dart';
import 'package:social_midia_firebase/theme/light_mode.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}
