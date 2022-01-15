import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class MyClipper extends CustomClipper<Path> {
  final String str;
  final Orientation orientation;
  MyClipper(this.str, this.orientation);

  @override
  Path getClip(Size size) {
    if (orientation == Orientation.portrait) {
      var xScale = size.width / 1300;
      var yScale = size.height / 2500;
      var offset = Offset(40, 15);
      final Matrix4 matrix4 = Matrix4.identity();
      matrix4.scale(xScale, yScale);
      final path = parseSvgPath(str).transform(matrix4.storage).shift(offset);
      return path;
    } else {
      var xScale = size.width / 6500;
      var yScale = size.height / 3600;
      var offset = Offset(30, 50);
      final Matrix4 matrix4 = Matrix4.identity();
      matrix4.scale(xScale, yScale);
      final path = parseSvgPath(str).transform(matrix4.storage).shift(offset);
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
