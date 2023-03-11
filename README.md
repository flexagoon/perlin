# Perlin

An implementation of the
[Perlin Noise](https://en.wikipedia.org/wiki/Perlin_noise) algorithm in Dart.

Exposes a single function - `perlin2d`, which takes the dimensions and the
frequency of the noise as well as an optional seed for the RNG.

```dart
// This will generate a 30*30 2D array with a random
// Perlin noise.
final noise = perlin2d(width: 3, height: 3, frequency: 10);
```
