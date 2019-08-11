import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 取消的二次弹窗确认
class CancelDialog extends StatelessWidget {
  final String title;
  final VoidCallback confirm;

  CancelDialog({
    this.title = '提示的内容',
    this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(600),
        // height: ScreenUtil().setWidth(300),
        constraints: BoxConstraints(
          maxHeight: ScreenUtil().setWidth(250),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(40),
              ),
              alignment: Alignment.center,
              child: Text(
                '$title',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: ScreenUtil().setSp(28),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(100),
              ),
              margin: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildActionItem(
                    text: '取消',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildActionItem(
                    text: '确定',
                    onTap: () {
                      if (confirm != null) {
                        Navigator.pop(context);
                        confirm();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem({
    String text,
    VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setWidth(140),
        height: ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: ScreenUtil().setWidth(1),
          ),
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(30),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '$text',
          style: TextStyle(
            color: Colors.black54,
            fontSize: ScreenUtil().setSp(28),
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
