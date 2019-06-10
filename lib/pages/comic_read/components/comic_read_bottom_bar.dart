import 'package:flutter/material.dart';

class ComicReadBottomBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback closeMenu;

  ComicReadBottomBar({
    Key key,
    this.scaffoldKey,
    this.closeMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildItem(
            icon: Icons.menu,
            text: '目录',
            onTap: () {
              closeMenu();
              scaffoldKey.currentState..openEndDrawer();
            }
          ),
          _buildItem(
            icon: Icons.skip_next,
            text: '进度',
          ),
          _buildItem(
            icon: Icons.brightness_auto,
            text: '夜间',
          ),
        ],
      ),
    );
  }

  Widget _buildItem({IconData icon, String text, VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 24.0,
            ),
            Container(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
