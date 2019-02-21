import 'package:flutter/material.dart';

class RefreshPageWrapper extends StatefulWidget {
  final RefreshCallback onRefresh;
  final Widget child;
  final Key key;

  RefreshPageWrapper({ this.key, this.onRefresh, this.child });

  _RefreshPageWrapperState createState() => _RefreshPageWrapperState();
}

class _RefreshPageWrapperState extends State<RefreshPageWrapper> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.key,
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
}
