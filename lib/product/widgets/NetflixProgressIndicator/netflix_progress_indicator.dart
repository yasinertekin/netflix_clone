import 'dart:math';
import 'package:flutter/material.dart';

class NetflixProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  final double radius;
  final Color backgroundColor;
  final Color progressColor;

  const NetflixProgressIndicator({
    super.key,
    this.strokeWidth = 4.0,
    this.radius = 20.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.red,
  });

  @override
  _NetflixProgressIndicatorState createState() => _NetflixProgressIndicatorState();
}

class _NetflixProgressIndicatorState extends State<NetflixProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: CustomPaint(
        painter: NetflixProgressPainter(
          progress: _controller,
          backgroundColor: widget.backgroundColor,
          progressColor: widget.progressColor,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class NetflixProgressPainter extends CustomPainter {
  final Animation<double> progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  NetflixProgressPainter({
    required this.progress,
    this.strokeWidth = 4.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.red,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;
    final double radius = min(halfWidth, halfHeight) - strokeWidth / 2;

    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(Offset(halfWidth, halfHeight), radius, paint);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressValue = progress.value * 2 * pi; // 0.0 to 1.0 to 0 to 2π
    const startAngle = -pi / 2;
    final endAngle = startAngle + progressValue;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(halfWidth, halfHeight), radius: radius),
      startAngle,
      endAngle - startAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
