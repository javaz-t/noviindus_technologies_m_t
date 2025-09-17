import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  4.vs(),
                  _shimmerContainer(height: 44),
                  24.vs(),
                  Wrap(
                    children: [
                      _shimmerContainer(height: 40, width: 193),
                      20.hs(),

                      _shimmerContainer(height: 40, width: 93),
                    ],
                  ),
                  20.vs(),
                  _mainShimmerContainer(),
                  28.vs(),
                  _mainShimmerContainer(),
                  28.vs(),
                  _mainShimmerContainer(),
                  20.vs(),
                  _mainShimmerContainer(),
                  28.vs(),
                  _mainShimmerContainer(),
                  28.vs(),
                  _mainShimmerContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_shimmerContainer({required double height, double width = double.maxFinite}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    height: height,
  );
}

_mainShimmerContainer() {
  return Column(children: [_shimmerContainer(height: 166)]);
}
