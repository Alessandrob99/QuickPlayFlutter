import 'package:flutter/material.dart';
import 'package:quickplay/pages/Login.dart';
import 'package:quickplay/pages/login_page.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'QuickPlay',
    home: LoginScreen(),
    );
  }
}

