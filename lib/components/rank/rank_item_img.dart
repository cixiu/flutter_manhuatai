import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/image_wrapper/image_wrapper.dart';

import 'package:flutter_manhuatai/models/rank_list.dart' as RankList;

class RankItemImg extends StatelessWidget {
  final RankList.ListSub item;

  RankItemImg({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageWrapper(

        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(item.comicName),
        )
      ],
    );
  }
}
