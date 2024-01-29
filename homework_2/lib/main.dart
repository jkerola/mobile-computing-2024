import 'package:flutter/material.dart';
import 'package:homework_2/homework_1.dart';

void main() {
  runApp(const Homework1());
}

class Homework1 extends StatelessWidget {
  const Homework1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeWork2(),
    );
  }
}

class HomeWork2 extends StatelessWidget {
  const HomeWork2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homework 2"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecondView())),
          child: const Icon(Icons.add)),
      body: const HomeWork1(),
    );
  }
}

class SecondView extends StatelessWidget {
  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Go back"),
        ),
      ),
      appBar: AppBar(
        title: const Text("Second view"),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back)),
      ),
    );
  }
}
