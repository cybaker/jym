import 'package:flutter/material.dart';

import 'presentation/JymHomePage.dart';

void main() {
  runApp(const JymApp());
}

class JymApp extends StatelessWidget {
  const JymApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Jym',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(),
      ),
      routes: {
        '/': (context) => const JymHomePage(),
      },
    );
  }
}

