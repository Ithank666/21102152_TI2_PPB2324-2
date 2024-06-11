import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tubes/firebase_options.dart';
import 'package:tubes/pages/home_page.dart';
import 'package:tubes/pages/register.dart';
import 'package:tubes/pages/DataDiri.dart';
import 'package:tubes/pages/beranda.dart';
import 'package:tubes/pages/login.dart'; // Import halaman login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/register': (context) => Register(),
        '/data_diri': (context) => DataDiri(),
        '/beranda': (context) => Beranda(),
        '/login': (context) => Login(), // Tambahkan route login
      },
    );
  }
}
