import 'package:flutter/material.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/MyExample.dart';
import 'package:on_boarding_screen/ui/on_boarding/registration_screen/registration_screen.dart';
import 'package:on_boarding_screen/ui/on_boarding/show_users.dart';

import 'ui/on_boarding/login_screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}

