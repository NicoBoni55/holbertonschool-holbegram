import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:holbegram/screens/signup_screen.dart';
import './screens/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myapp());
}


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordConfirmController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Holbegram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(
        emailController: emailController, 
        usernameController: usernameController, 
        passwordController: passwordController, 
        passwordConfirmController: passwordConfirmController)
    );
  }
}