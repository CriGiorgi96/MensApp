import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();

  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(database: database),
    );
  }
}
