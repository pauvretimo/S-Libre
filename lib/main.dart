import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:learn/paths.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App salles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

/// A Stateful widget that paints flutter logo using [CustomPaint] and [Path].
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.scale(
        scale: 1,
        child: Align(
          alignment: Alignment.topLeft,
          child: Stack(
            children: paths.map((e) {
              return ClipPath(
                child: Material(
                  child: InkWell(
                    child: null,
                    onTap: () {
                      print("test");
                    },
                  ),
                  color: (e[1] as Color),
                ),
                clipper: MyClipper(e[0] as String),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final String str;
  MyClipper(this.str);

  @override
  Path getClip(Size size) {
    final path = parseSvgPath(str);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
