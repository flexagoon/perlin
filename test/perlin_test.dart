import 'package:perlin/perlin.dart';
import 'package:test/test.dart';

void main() {
  test('Example generation matches the expected result', () {
    const expected = [
      [0.0, 0.0, 0.0],
      [-0.26337448559670784, -0.14936747447035514, 0.2892851699436061],
      [-0.13991769547325106, -0.12345679012345684, 0.3868312757201647],
    ];
    final noise = perlin2d(width: 1, height: 1, seed: 1, frequency: 3);
    expect(noise, equals(expected));
  });
}
