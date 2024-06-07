import 'package:flutter/material.dart';
import 'kalender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalender App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KalenderPage(),
    );
  }
}
