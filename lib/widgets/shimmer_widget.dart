import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wiifd/utilties/app_colors.dart';

class KShimmer extends StatelessWidget {
  const KShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor().cardColor!,
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                bottom: 10,
                top: 12),
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SizedBox(height: 80),
            ),
          );
        },
      ),
    );
  }
}
