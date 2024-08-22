// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/articles_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storyblok Articles',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArticlesListScreen(),
    );
  }
}
