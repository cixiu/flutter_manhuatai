import 'package:flutter/material.dart';

class RelatedComics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            child: Text('相关漫画'),
          ),
        ],
      ),
    );
  }
}
