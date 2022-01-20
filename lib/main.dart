import 'package:flutter/material.dart';
import 'package:kelimeezberleme/pages/temporary.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kelime Ezberleme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  TemporaryPage(),
    );
  }
}


