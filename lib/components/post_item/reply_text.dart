import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'post_special_text_span_builder.dart';

class ReplyText extends SpecialText {
  static const String flag = "{reply:";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  final BuilderType type;
  final TextStyle replyStyle;
  final VoidCallback replyTap;

  ReplyText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback onTap, {
    this.showAtBackground = false,
    this.type,
    this.start,
    this.replyStyle,
    this.replyTap,
  }) : super(flag, "}", textStyle, onTap: onTap);

  @override
  TextSpan finishText() {
    TextStyle textStyle = this.textStyle?.copyWith(
          color: Colors.blue,
          fontSize: ScreenUtil().setSp(28),
        );

    // final String atText = toString();
    final String content = getContent();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: content,
            actualText: content,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: replyStyle ?? textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (replyTap != null) {
                      replyTap();
                      return;
                    }
                    if (onTap != null) onTap(content);
                  })
                : null,
          )
        : SpecialTextSpan(
            text: content,
            actualText: content,
            start: start,
            style: replyStyle ?? textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (replyTap != null) {
                      replyTap();
                      return;
                    }
                    if (onTap != null) onTap(content);
                  })
                : null,
          );
  }
}
