import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/signup_screen.dart';
import 'package:holbegram/screens/home.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Holbegram',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (snapshot.hasData) {
              return FutureBuilder(
                future: Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).refreshUser(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Home();
                },
              );
            } else {
              return SignUp();
            }
          },
        ),
      ),
    );
  }
}
