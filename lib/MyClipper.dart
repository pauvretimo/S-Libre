import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class MyClipperPortrait extends CustomClipper<Path> {
  final String str;
  MyClipperPortrait(this.str);

  @override
  Path getClip(Size size) {
    var xScale = size.width / 1300;
    var yScale = size.height / 2500;
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(xScale, yScale);
    final path =
        parseSvgPath(str).transform(matrix4.storage).shift(Offset(40, 15));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class MyClipperLandscape extends CustomClipper<Path> {
  final String str;
  MyClipperLandscape(this.str);

  @override
  Path getClip(Size size) {
    var xScale = size.width / 2500;
    var yScale = size.height / 4300;
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(xScale, yScale);
    final path =
        parseSvgPath(str).transform(matrix4.storage).shift(Offset(0, 100));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
