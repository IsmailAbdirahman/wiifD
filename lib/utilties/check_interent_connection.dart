import 'dart:io';

import 'package:wiifd/main.dart';

Future<bool> checkInternet() async {
  final result = await InternetAddress.lookup('example.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    logger.w("Is Conected");
    return true;
  }
  logger.w("NotConected");

  return false;
}
