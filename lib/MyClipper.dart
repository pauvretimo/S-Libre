import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  final Path str;
  final Orientation orientation;
  final int xS;
  final int yS;
  MyClipper(
    this.str,
    this.orientation,
    this.xS,
    this.yS,
  );

  @override
  Path getClip(Size size) {
    var xScale = size.width / xS;
    var yScale = size.height / yS;
    final Matrix4 matrix4 = Matrix4.identity();

    if (orientation == Orientation.portrait) {
      var offset =
          Offset(40.0 * (size.width / 600.0), 15.0 * (size.height / 1000.0));
      matrix4.scale(xScale, yScale);
      final path = str.transform(matrix4.storage).shift(offset);
      return path;
    } else {
      var offset =
          Offset(30.0 * (size.width / 1000.0), 50.0 * (size.height / 600.0));
      matrix4.scale(xScale, yScale);
      final path = str.transform(matrix4.storage).shift(offset);
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
