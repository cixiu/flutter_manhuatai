import 'package:flutter/material.dart';

class CommonSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  CommonSliverPersistentHeaderDelegate({
    this.height,
    this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(CommonSliverPersistentHeaderDelegate oldDelegate) {
    //print("shouldRebuild---------------");
    return oldDelegate != this;
  }
}
