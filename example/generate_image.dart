import 'dart:io';

import 'package:image/image.dart';
import 'package:perlin/perlin.dart';

void main() {
  const width = 10;
  const height = 10;

  final noise = perlin2d(width: width, height: height);

  final image = Image(width: noise.length, height: noise.length);
  for (final pixel in image) {
    final value = (noise[pixel.x][pixel.y] * 0.5 + 0.5) * 255;
    pixel.setRgb(value, value, value);
  }

  final png = encodePng(image);
  File('image.png').writeAsBytes(png);
}
