import 'package:flutter/material.dart';

class RefreshLoading extends StatefulWidget {
  _RefreshLoadingState createState() => _RefreshLoadingState();
}

class _RefreshLoadingState extends State<RefreshLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Positioned(
            top: 40.0,
            child: ScaleTransition(
              scale: CurvedAnimation(
                  parent: _controller, curve: Curves.fastOutSlowIn),
              child: RefreshProgressIndicator(),
            )),
      ],
    );
  }
}
