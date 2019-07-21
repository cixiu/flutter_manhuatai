import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/post_item/image_text.dart';
import 'emoji_text.dart';
import 'reply_text.dart';
import 'self_text.dart';
// import 'image_span_text.dart';

class PostSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  /// whether show background for @somebody
  final bool showAtBackground;
  final BuilderType type;
  final TextStyle selfStyle;
  final VoidCallback selfTap;
  final TextStyle replyStyle;
  final VoidCallback replyTap;

  PostSpecialTextSpanBuilder({
    this.showAtBackground = false,
    this.selfStyle,
    this.selfTap,
    this.replyStyle,
    this.replyTap,
    this.type = BuilderType.extendedText,
  });

  @override
  TextSpan build(
    String data, {
    TextStyle textStyle,
    onTap,
  }) {
    var textSpan = super.build(
      data,
      textStyle: textStyle,
      onTap: onTap,
    );
    return textSpan;
  }

  @override
  SpecialText createSpecialText(
    String flag, {
    TextStyle textStyle,
    SpecialTextGestureTapCallback onTap,
    int index,
  }) {
    if (flag == null || flag == "") {
      return null;
    }

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, EmojiText.flag)) {
      return EmojiText(
        textStyle,
        start: index - (EmojiText.flag.length - 1),
      );
    } else if (isStart(flag, ImageText.flag)) {
      return ImageText(
        textStyle,
        start: index - (ImageText.flag.length - 1),
      );
    } else if (isStart(flag, SelfText.flag)) {
      return SelfText(
        textStyle,
        onTap,
        start: index - (SelfText.flag.length - 1),
        showAtBackground: showAtBackground,
        type: type,
        selfStyle: selfStyle,
        selfTap: selfTap,
      );
    } else if (isStart(flag, ReplyText.flag)) {
      return ReplyText(
        textStyle,
        onTap,
        start: index - (ReplyText.flag.length - 1),
        showAtBackground: showAtBackground,
        type: type,
        replyStyle: replyStyle,
        replyTap: replyTap,
      );
    }

    return null;
  }
}

enum BuilderType { extendedText, extendedTextField }
