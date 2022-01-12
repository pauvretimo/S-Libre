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
      body: Stack(
        alignment: Alignment.topLeft,
        children: pathsv.map((e) {
          return ClipPath(
            // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
            child: Material(
              child: InkWell(
                child: null,
                onTap: () {
                  print(e[1]); //mettre la sortie de clique ici
                },
              ),
              color: (e[1]
                  as Color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
            ),
            clipper: MyClipper(e[0] as String),
          );
        }).toList(),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final String str;
  MyClipper(this.str);

  @override
  Path getClip(Size size) {
    var xScale = size.width / 1400;
    var yScale = size.height / 2800;
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(xScale, yScale);
    final path =
        parseSvgPath(str).transform(matrix4.storage).shift(Offset(12, 12));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
