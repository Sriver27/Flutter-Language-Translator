import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StyleSync',
      theme: ThemeData(
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: const Color(0xFF16181A)),
      home: const MyHomePage(),
    );
  }
}
