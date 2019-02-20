import 'package:flutter/material.dart';

class RefreshLoading extends StatefulWidget {
  _RefreshLoadingState createState() => _RefreshLoadingState();
}

class _RefreshLoadingState extends State<RefreshLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    animation =Tween(begin: 0.0, end: 40.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    ))..addListener(() {
      setState(() {
        
      });
    });

    _controller.forward();
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
                  parent: _controller, curve: Curves.fastOutSlowIn, reverseCurve: Curves.easeOut),
              child: RefreshProgressIndicator(),
            )),
            // child: Container(
            //   width: animation.value,
            //   height: animation.value,
            //   decoration: BoxDecoration(
            //     // color: Colors.red,
            //     shape: BoxShape.circle
            //   ),
            //   child: RefreshProgressIndicator(),
            // ),
        // )
      ],
    );
  }
}
