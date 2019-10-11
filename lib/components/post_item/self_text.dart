import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'post_special_text_span_builder.dart';

class SelfText extends SpecialText {
  static const String flag = "@";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  final BuilderType type;
  final TextStyle selfStyle;
  final VoidCallback selfTap;

  SelfText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback onTap, {
    this.showAtBackground = false,
    this.type,
    this.start,
    this.selfStyle,
    this.selfTap,
  }) : super(flag, "：", textStyle, onTap: onTap);

  @override
  TextSpan finishText() {
    TextStyle textStyle =
        this.textStyle?.copyWith(color: Colors.blue, fontSize: 16.0);

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
            style: selfStyle ?? textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (selfTap != null) {
                      selfTap();
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
            style: selfStyle ?? textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (selfTap != null) {
                      selfTap();
                      return;
                    }
                    if (onTap != null) onTap(content);
                  })
                : null,
          );
  }
}
