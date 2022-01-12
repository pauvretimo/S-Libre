import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

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
