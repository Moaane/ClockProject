import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helloworld/ui/style.dart';
import 'package:helloworld/utils/time_model.dart';

class ClockWidget extends StatefulWidget {
  ClockWidget(this.time, {Key? key}) : super(key: key);
  TimeModel time;

  @override
  State<ClockWidget> createState() => ClockWidgetState();
}

class ClockWidgetState extends State<ClockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: AppStyle.primaryColor.withAlpha(80), blurRadius: 38.0),
      ]),
      height: 300.0,
      width: 300.0,
      child: CustomPaint(
        painter: ClockPainter(widget.time),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  TimeModel? time;
  ClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    double secRad = ((pi / 2)) - ((pi / 30)) * this.time!.sec! % (2 * pi);
    double minRad = ((pi / 2)) - ((pi / 30)) * this.time!.min! % (2 * pi);
    double hourRad = ((pi / 2)) - ((pi / 6)) * this.time!.hour! % (2 * pi);

    var centerX = size.height / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var secHeight = radius / 2;
    var minHeight = radius / 2 - 10;
    var hourHeight = radius / 2 - 25;

    var seconds = Offset(
        centerX + secHeight * cos(secRad), centerY - secHeight * sin(secRad));
    var minutes = Offset(
        centerX + minHeight * cos(minRad), centerY - minHeight * sin(minRad));
    var hours = Offset(centerX + hourHeight * cos(hourRad),
        centerY - hourHeight * sin(hourRad));

    //setting Brush
    var fillBrush = Paint()
      ..color = AppStyle.primaryColor
      ..strokeCap = StrokeCap.round;

    var centerDotBrush = Paint()..color = Colors.white;

    var secBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round;

    var minBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    var hourBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(center, radius - 40, fillBrush);

    canvas.drawLine(center, seconds, secBrush);
    canvas.drawLine(center, minutes, minBrush);
    canvas.drawLine(center, hours, hourBrush);

    canvas.drawCircle(center, 16, centerDotBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
