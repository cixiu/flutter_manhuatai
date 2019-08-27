import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_manhuatai/common/model/satellite_comment.dart';
import 'package:flutter_manhuatai/components/post_item/emoji_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef Future<void> SubmitCallback({
  String value,
  bool isReply,
  SatelliteComment comment,
});

class CommentTextInput extends StatefulWidget {
  final SubmitCallback submit;
  final double keyboardHeight;

  CommentTextInput({
    Key key,
    @required this.keyboardHeight,
    this.submit,
  }) : super(key: key);

  @override
  CommentTextInputState createState() => CommentTextInputState();
}

class CommentTextInputState extends State<CommentTextInput> {
  String _value = '';
  TextEditingController _textEditingController = TextEditingController();
  String _hintText = '神评机会近在眼前~';
  FocusNode _focusNode = FocusNode();
  double _keyboardHeight = 267.0;
  bool activeEmojiGird = false;
  bool _isReply = false;
  SatelliteComment _replyComment;

  bool get showCustomKeyBoard => activeEmojiGird;

  void _insertText(String text) {
    bool isBack = text == '[/返回]';
    if (isBack) {
      if (_value == '') {
        return;
      }
      var backReg = RegExp(r'(\[\/[\u2E80-\u9FFF]+\])$');
      int index = _value.lastIndexOf(backReg);
      if (index > -1) {
        setState(() {
          _value = _value.replaceFirst(backReg, '');
        });
      } else {
        setState(() {
          _value = _value.substring(0, _value.length - 1);
        });
      }
    } else {
      setState(() {
        _value += text;
      });
    }

    _textEditingController.value = TextEditingValue(
      text: _value ?? '',
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: _value.length,
        ),
      ),
    );
  }

  void _update(Function change) {
    if (showCustomKeyBoard) {
      change();
    } else {
      SystemChannels.textInput.invokeMethod('TextInput.hide').whenComplete(() {
        Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
          change();
        });
      });
    }
  }

  void blurKeyBoard() {
    FocusScope.of(context).unfocus();
    hideEmoji();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _hintText = '神评机会近在眼前~';
        _isReply = false;
        _replyComment = null;
      });
    });
  }

  // 主动控制输入框聚焦
  void focus({String hintText}) {
    FocusScope.of(context).requestFocus(_focusNode);
    if (hintText != null) {
      setState(() {
        _hintText = hintText;
      });
    }
  }

  // 设置要回复的评论变量
  void replyComment({SatelliteComment comment}) {
    setState(() {
      _isReply = true;
      _replyComment = comment;
    });
  }

  void hideEmoji() {
    if (showCustomKeyBoard) {
      setState(() {
        activeEmojiGird = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (widget.keyboardHeight > 0) {
      activeEmojiGird = false;
    }

    _keyboardHeight = max(_keyboardHeight, widget.keyboardHeight);

    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            minHeight: ScreenUtil().setWidth(100),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setWidth(20),
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[350],
                width: ScreenUtil().setWidth(1),
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: ScreenUtil().setWidth(60),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[350],
                      width: ScreenUtil().setWidth(1),
                    ),
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    // specialTextSpanBuilder:
                    //     PostSpecialTextSpanBuilder(
                    //   showAtBackground: true,
                    //   type: BuilderType.extendedTextField,
                    // ),

                    onChanged: (val) {
                      setState(() {
                        _value = val;
                      });
                    },
                    controller: _textEditingController,
                    minLines: 1,
                    maxLines: 6,
                    focusNode: _focusNode,
                    strutStyle: StrutStyle(
                      forceStrutHeight: true,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                    decoration: InputDecoration(
                      hintText: _hintText,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Colors.grey[350],
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),
                        vertical: ScreenUtil().setWidth(10),
                      ),
                    ),
                    //textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _update(() {
                    setState(() {
                      activeEmojiGird = true;
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                  ),
                  child: Image.asset(
                    'lib/images/ico_expression.png',
                    width: ScreenUtil().setWidth(44),
                    height: ScreenUtil().setWidth(44),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (widget.submit != null) {
                    await widget.submit(
                      value: _value,
                      isReply: _isReply,
                      comment: _replyComment,
                    );
                    setState(() {
                      _value = '';
                      _textEditingController.value = TextEditingValue(
                        text: _value,
                      );
                      activeEmojiGird = false;
                      _hintText = '神评机会近在眼前~';
                      _isReply = false;
                      _replyComment = null;
                    });
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                  ),
                  child: Text(
                    '发表',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenUtil().setSp(32),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: showCustomKeyBoard ? _keyboardHeight : 0.0,
          child: _buildCustomKeyBoard(),
        ),
      ],
    );
  }

  Widget _buildCustomKeyBoard() {
    if (!showCustomKeyBoard) {
      return Container();
    }
    if (activeEmojiGird) {
      return _buildEmojiGird();
    }
    return Container();
  }

  Widget _buildEmojiGird() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[300],
            width: ScreenUtil().setWidth(1),
          ),
        ),
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(0.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: ScreenUtil().setWidth(10),
          mainAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) {
          var key = EmojiUitl.instance.emojiList[index];
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _insertText('$key');
            },
            child: Container(
              child: Center(
                child: Image.asset(
                  EmojiUitl.instance.emojiMap['$key'],
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setWidth(60),
                ),
              ),
            ),
          );
        },
        itemCount: EmojiUitl.instance.emojiMap.length,
      ),
    );
  }
}
