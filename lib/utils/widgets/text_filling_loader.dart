import 'package:flutter/material.dart';
import 'package:moben/utils/styles.dart';

class TextFillingLoader extends StatefulWidget {
  final String text;
  final Duration duration;

  TextFillingLoader({required this.text, required this.duration});

  @override
  _TextFillingLoaderState createState() => _TextFillingLoaderState();
}

class _TextFillingLoaderState extends State<TextFillingLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size textSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    textSize = _calculateTextSize(widget.text, TextStyle(fontSize: 40));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Size _calculateTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.rtl,
    )..layout();
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: textSize.width,
      height: textSize.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: TextFillingPainter(
              text: widget.text,
              progress: _controller.value,
              textStyle: AppStyles.quranTextStyle50,
              fillColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

class TextFillingPainter extends CustomPainter {
  final String text;
  final double progress;
  final TextStyle textStyle;
  final Color fillColor;

  TextFillingPainter({
    required this.text,
    required this.progress,
    required this.textStyle,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textAlign: TextAlign.left,
      textDirection: TextDirection.rtl,
    )..layout();

    final double fillWidth = textPainter.width * progress;

    // Draw the text in the fill color
    final fillTextPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle.copyWith(color: fillColor)),
      textAlign: TextAlign.left,
      textDirection: TextDirection.rtl,
    )..layout();

    canvas.saveLayer(Offset.zero & size, Paint());

    // Clip the area to fill with color, starting from the right
    canvas.clipRect(Rect.fromLTWH(textPainter.width - fillWidth, 0, fillWidth, textPainter.height));
    fillTextPainter.paint(canvas, Offset.zero);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
