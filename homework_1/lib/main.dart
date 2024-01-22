import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Homework 1"),
        ),
        body: ListView(
          children: [
            const FontColorChanger(),
            const FontChanger(),
            const RotateImage(),
            for (var i = 0; i < 10; i++)
              const ListTile(title: Text("Filler for scroll"))
          ],
        ),
      ),
    );
  }
}

class FontColorChanger extends StatefulWidget {
  const FontColorChanger({super.key});

  @override
  State<FontColorChanger> createState() => _FontColorChangerState();
}

class _FontColorChangerState extends State<FontColorChanger> {
  Color col = Colors.green;
  var opts = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Click me to change font colors",
        style: TextStyle(
          fontFamily: 'Times New Roman',
          color: col,
        ),
      ),
      onTap: () => setState(() => col = opts[Random().nextInt(opts.length)]),
      trailing: const Icon(Icons.replay),
    );
  }
}

class FontChanger extends StatefulWidget {
  const FontChanger({super.key});

  @override
  State<FontChanger> createState() => _FontChangerState();
}

class _FontChangerState extends State<FontChanger> {
  var fonts = [
    GoogleFonts.lato(),
    GoogleFonts.rubik(),
    GoogleFonts.zenTokyoZoo(),
    GoogleFonts.unicaOne()
  ];
  var current = GoogleFonts.lato();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${current.fontFamily}",
        style: current,
      ),
      onTap: () =>
          setState(() => current = fonts[Random().nextInt(fonts.length)]),
      trailing: const Icon(Icons.replay),
    );
  }
}

class RotateImage extends StatefulWidget {
  const RotateImage({super.key});

  @override
  State<RotateImage> createState() => _RotateImageState();
}

class _RotateImageState extends State<RotateImage> {
  var rotation = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => setState(() => rotation += 1 / 2 * pi),
        child: Container(
          transformAlignment: Alignment.center,
          transform: Matrix4.rotationZ(rotation),
          child: const Image(
            image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
