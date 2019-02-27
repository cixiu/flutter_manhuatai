import 'package:flutter/material.dart';

class RankTitle extends StatelessWidget {
  final String type;
  final String title;

  final Map<String, String> titleImg = {
    'all': 'lib/images/icon_comicrank_zhb28.png',
    'self': 'lib/images/icon_comicrank_zzb28.png',
    'new': 'lib/images/icon_comicrank_xzb28.png',
    'dark': 'lib/images/icon_comicrank_hmb1.png',
    'charge': 'lib/images/icon_comicrank_ffb28.png',
    'boy': 'lib/images/icon_comicrank_snb128.png',
    'girl': 'lib/images/icon_comicrank_snb28.png',
    'serialize': 'lib/images/icon_comicrank_lzb28.png',
    'finish': 'lib/images/icon_comicrank_wjb28.png',
    'free': 'lib/images/icon_comicrank_mfb28.png',
  };

  RankTitle({Key key, @required this.type, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                titleImg[type],
                width: 24.0,
                height: 24.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text('TOP 100', style: TextStyle(
              color: Colors.grey,
              fontSize: 8.0,
            ),),
            // onPressed: () {},
          )
        ],
      ),
    );
  }
}
