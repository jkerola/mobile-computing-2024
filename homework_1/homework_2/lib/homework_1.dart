import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class HomeWork1 extends StatelessWidget {
  const HomeWork1({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const FontColorChanger(),
      const FontChanger(),
      const RotateImage(),
      for (var i = 0; i < 10; i++)
        const ListTile(title: Text("Filler for scroll"))
    ]);
  }
}
