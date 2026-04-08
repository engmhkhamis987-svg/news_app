import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopHeadlinesShimmer extends StatelessWidget {
  const TopHeadlinesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(height: 80, color: Colors.white),
          ),
        );
      },
    );
  }
}
