import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

/// Tesseract widget
class Tesseract extends StatefulWidget {
  const Tesseract({super.key});

  @override
  State<Tesseract> createState() => _TesseractState();
}

class _TesseractState extends State<Tesseract> with SingleTickerProviderStateMixin {
  double _time = 0;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time += 0.025;
      });
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ShaderBuilder(
          assetKey: 'shaders/tesseract.glsl',
          child: SizedBox(
            height: size.height,
            width: size.width,
          ), (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) {
            shader.setFloat(0, _time);
            shader.setFloat(1, size.width);
            shader.setFloat(2, size.height);
            canvas.drawPaint(Paint()..shader = shader);
          },
          child: child!,
        );
      }),
    );
  }
}
