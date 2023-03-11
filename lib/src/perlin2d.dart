import 'dart:math';

/// Generates a 2D perlin noise.
///
/// Takes the dimensions of the generated
/// noise as arguments ([width] and [height]),
/// as well as the noise [frequency]. You can
/// also set a custon [seed] if you don't want
/// it to be random.
List<List<double>> perlin2d({
  required int width,
  required int height,
  int frequency = 10,
  int? seed,
}) {
  // Generate a random seed if a custom one isn't set.
  seed ??= Random().nextInt(10000);

  // Iterate through all of the candidate points.
  return List.generate(height * frequency, (y) {
    return List.generate(width * frequency, (x) {
      // Get the double coordinate of the point.
      final pointX = x / frequency;
      final pointY = y / frequency;

      // Calculate the value of the point based on its coordinates.
      return _perlinAtPoint(pointX, pointY, seed!);
    });
  });
}

/// Gets the value of the point at ([x]; [y]).
double _perlinAtPoint(double x, double y, int seed) {
  // Find the corners of the 1:1 cell that the point is located in.
  final cellX0 = x.floor();
  final cellX1 = cellX0 + 1;
  final cellY0 = y.floor();
  final cellY1 = cellY0 + 1;

  // Find the dot products of gradient and offset for each of the four corners.
  final corner1 = _gradientOffsetDotProduct(cellX0, cellY0, x, y, seed);
  final corner2 = _gradientOffsetDotProduct(cellX1, cellY0, x, y, seed);
  final corner3 = _gradientOffsetDotProduct(cellX0, cellY1, x, y, seed);
  final corner4 = _gradientOffsetDotProduct(cellX1, cellY1, x, y, seed);

  // Get the distances from the point to (x0; y0) of the cell.
  // Those distances are used as interpolation weights.
  final wx = x - cellX0;
  final wy = y - cellY0;

  // Interpolate the top corners.
  final top = _interpolate(corner1, corner2, wx);

  // Interpolate the bottom corners.
  final bottom = _interpolate(corner3, corner4, wx);

  // Interpolate them together to get the final value.
  return _interpolate(top, bottom, wy);
}

/// Find the dot product of the offset vector and a
/// pseudo-random gradient vector for the corner ([cornerX]; [cornerY])
/// of cell containing the point ([pointX]; [pointY]).
double _gradientOffsetDotProduct(
  int cornerX,
  int cornerY,
  double pointX,
  double pointY,
  int seed,
) {
  // Generate the gradient vector.
  final gradient = _gradient(cornerX, cornerY, seed);

  // Find the offset vector of the point.
  final distanceX = pointX - cornerX;
  final distanceY = pointY - cornerY;

  // Calculate the dot product.
  return distanceX * gradient.x + distanceY * gradient.y;
}

/// Generates a pseudo-random gradient for a given point.
///
/// The hash is generated with a pseudo-random algorithm used by the FastNoise
/// library. The original algorithm by Ken Perlin produces slightly better
/// results, but it is weirdly complicated and has a fixed seed.
///
/// The FastNoise algorithm can be found [here](https://github.com/Auburn/FastNoiseLite/blob/95900f7372d9aad1691cfeabf45103a132a4664f/CSharp/FastNoiseLite.cs#L630).
_Vector2 _gradient(int x, int y, int seed) {
  var hash = seed;

  // Generate a pseudo-random hash.
  hash ^= x * 1619;
  hash ^= y * 31337;
  hash *= 0x27d4eb2d;
  hash ^= hash >> 15;

  // The gradient is chosen from one of those values:
  const grads = [
    _Vector2(-1, -1),
    _Vector2(1, -1),
    _Vector2(-1, 1),
    _Vector2(1, 1),
    _Vector2(0, -1),
    _Vector2(-1, 0),
    _Vector2(0, 1),
    _Vector2(1, 0),
  ];

  return grads[hash & 7];
}

/// Create smooth interpolation between two values by using a smoothstep curve.
double _interpolate(double a, double b, double t) {
  // The ease curve is defined as 6t^5 - 15t^4 + 10t^3.
  return (b - a) * ((t * (t * 6.0 - 15.0) + 10.0) * t * t * t) + a;
}

class _Vector2 {
  const _Vector2(this.x, this.y);

  final int x;
  final int y;
}
