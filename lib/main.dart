import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:isolates/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
