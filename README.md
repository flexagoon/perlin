# Perlin

An implementation of the
[Perlin Noise](https://en.wikipedia.org/wiki/Perlin_noise) algorithm in Dart.

Exposes a single function - `perlin2d`, which takes the dimensions and the
frequency of the noise as well as an optional seed for the RNG.

```dart
// This will generate a 100*100 2D array with a random
// Perlin noise.
final noise = perlin2d(width: 10, height: 10, frequency: 10);
```

The example in `example/generate_image.dart` creates an image from the generated
noise:

![noise](https://user-images.githubusercontent.com/66178592/224476874-b3c50361-70a1-45ef-b85a-2e4b8290a9f0.png)
