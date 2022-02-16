import 'package:flutter/material.dart';

class BuildIntroImage extends StatelessWidget {
  final String assetName;

  BuildIntroImage({required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetName, width: 350);
  }
}
