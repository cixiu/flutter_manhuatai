import 'package:flutter/material.dart';

class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  CustomSliverChildBuilderDelegate(
    IndexedWidgetBuilder builder, {
    int childCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : super(
          builder,
          childCount: childCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        );

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    print('firstIndex: $firstIndex lastIndex: $lastIndex');
    super.didFinishLayout(firstIndex, lastIndex);
  }
}
