import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:learn/paths.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  bool showBorder = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.scale(
        scale: 1,
        child: GestureDetector(
          child: Transform.rotate(
            angle: 0,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 10,
                height: 10,
                child: Stack(
                  children: paths.map((e) {
                    return CustomPaint(
                        painter: MyPainter(
                            parseSvgPath(e[0] as String), e[1] as Color,
                            showPath: showBorder));
                  }).toList(),
                ),
              ),
            ),
          ),
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              // hide/show border
              showBorder = !showBorder;
            });
          },
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Path path;
  final Color color;
  final bool showPath;
  MyPainter(this.path, this.color, {this.showPath = true});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 4.0;
    canvas.drawPath(path, paint);
    if (showPath) {
      var border = Paint()
        ..color = Colors.black
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, border);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
