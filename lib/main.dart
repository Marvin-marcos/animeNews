<<<<<<< HEAD
 import 'package:filmes_hobby/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

runApp(const MyApp());
}


class MyApp extends StatelessWidget {
const MyApp({super.key});


@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'animeNews',
theme: ThemeData(primarySwatch: Colors.deepPurple),
home: const AuthScreen(),
);
}
}
=======
import 'package:flutter/material.dart';
import 'package:anime_news/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

>>>>>>> a113246fd4774b5b4e5c187dc01c24d1760ddc16
