import 'package:finmanage_mobile/repository/database_helper.dart';
import 'package:finmanage_mobile/starter_page/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fin Manage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartScreenWrapper(),
    );
  }
}

class StartScreenWrapper extends StatelessWidget {
  const StartScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.database,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Database is initializing...');
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error initializing database: ${snapshot.error}');
          return const Center(child: Text('Error initializing database'));
        } else {
          print('Database initialized successfully');
          return const StartScreen();
        }
      },
    );
  }
}