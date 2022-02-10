import 'dart:math';

class RandomID {
  Random _random = Random();



  String generateID() {
    return _random.nextInt(1000).toString();
  }
}
