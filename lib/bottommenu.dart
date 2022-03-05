import 'package:flutter/material.dart';

class bottomDrawer extends StatefulWidget {
  final ScrollController sc;
  ValueNotifier<double> pos;
  Function callback;
  bottomDrawer(this.sc, this.pos, this.callback);
  @override
  State<StatefulWidget> createState() => _bottomDrawer(sc, pos, callback);
}

class _bottomDrawer extends State<bottomDrawer> with TickerProviderStateMixin {
  final ScrollController sc;
  ValueNotifier<double> pos;
  Function callback;
  _bottomDrawer(this.sc, this.pos, this.callback);

  @override
  Widget build(BuildContext context) {
    return ListView(controller: sc, children: [
      Container(
          height: 50,
          child: Stack(children: [
            ValueListenableBuilder<double>(
                valueListenable: pos,
                builder: (BuildContext context, double value, Widget? child) {
                  return ClipPath(
                    key: ValueKey(pos),
                    child: Container(color: Colors.blue),
                    clipper: buttonClipper(pos.value),
                  );
                })
          ])),
      SizedBox(
          height: 40,
          child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: InkWell(onTap: () {
                callback();
              }))),
      SizedBox(
          height: 40,
          child: Container(
            color: Colors.blue,
            child: Text("txt"),
          )),
      SizedBox(
          height: 40,
          child: Container(
            color: Colors.blue,
            child: Text("txt"),
          )),
      SizedBox(
          height: 40,
          child: Container(
            color: Colors.blue,
            child: Text("txt"),
          )),
    ]);
  }
}

class buttonClipper extends CustomClipper<Path> {
  final double top;
  buttonClipper(
    this.top,
  );

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(.0, 51.0);
    path.lineTo(size.width / 2.0 - 40.0 + (top * 10), 51.0);
    path.quadraticBezierTo(size.width / 2.0 - 23.0 + (top * 13), 51.0,
        size.width / 2.0 - 23.0 + (top * 13), 41.0 + (top * 10.0));
    path.cubicTo(
        size.width / 2.0 - 18.0 + (top * 15),
        11.0 + (top * 40.0),
        size.width / 2.0 + 18.0 - (top * 15),
        11.0 + (top * 40.0),
        size.width / 2.0 + 23.0 - (top * 13),
        41.0 + (top * 10));
    path.quadraticBezierTo(size.width / 2.0 + 23.0 - (top * 13), 51.0,
        size.width / 2.0 + 40.0 - (top * 10), 51.0);
    path.lineTo(size.width, 51.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
