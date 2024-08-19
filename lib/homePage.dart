import 'dart:isolate';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/redhair-walk.webp'),
              //Normal
              ElevatedButton(
                onPressed: () async {
                  int total = await complexTask1();
                  debugPrint('Result 1: $total');
                  _showSnackBar(context, '$total times iterated' );
                },
                child: const Text('Normal Task with high iteration'),
              ),
              const SizedBox(height: 10,),
              //Isolate
              ElevatedButton(
                onPressed: () async {
                  final receivePort = ReceivePort();
                  await Isolate.spawn(complexTask2, receivePort.sendPort);
                  receivePort.listen((total) {
                    _showSnackBar(context, '$total times iterated' );
                  });
                },
                child: const Text('Isolate Task with high iteration'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int complexTask1() {
    int total = 0;
    for (int i = 0; i < 10000000000; i++) {
      total += i;
    }
    return total;
  }
}

complexTask2(SendPort sendPort) {
  var total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  sendPort.send(total);
}