import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class MyClipper extends CustomClipper<Path> {
  final String str;
  final Orientation orientation;
  final int xS;
  final int yS;
  MyClipper(this.str, this.orientation, this.xS, this.yS);

  @override
  Path getClip(Size size) {
    var xScale = size.width / xS;
    var yScale = size.height / yS;
    final Matrix4 matrix4 = Matrix4.identity();

    if (orientation == Orientation.portrait) {
      var offset = Offset(40, 15);
      matrix4.scale(xScale, yScale);
      final path = parseSvgPath(str).transform(matrix4.storage).shift(offset);
      return path;
    } else {
      var offset = Offset(30, 50);
      matrix4.scale(xScale, yScale);
      final path = parseSvgPath(str).transform(matrix4.storage).shift(offset);
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
