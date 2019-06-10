import 'package:flutter/material.dart';

class ComicReadStatusBar extends StatelessWidget {
  final String chapterName;

  ComicReadStatusBar({
    Key key,
    this.chapterName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusHeight = MediaQuery.of(context).padding.top + 50.0;
    return Container(
      height: statusHeight,
      color: Colors.grey[900],
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 50.0,
              alignment: Alignment.center,
              child: Text(
                chapterName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 9.0,
              ),
              child: Icon(
                Icons.navigate_before,
                color: Colors.white,
                size: 32.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
