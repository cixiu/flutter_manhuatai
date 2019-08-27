import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_manhuatai/components/post_item/image_text.dart';
import 'package:flutter_manhuatai/components/post_item/satellite_link_text.dart';
import 'package:flutter_manhuatai/components/post_item/web_view_link_text.dart';
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
  final TextStyle linkStyle;
  final BuildContext context;

  PostSpecialTextSpanBuilder({
    this.showAtBackground = false,
    this.selfStyle,
    this.selfTap,
    this.replyStyle,
    this.replyTap,
    this.linkStyle,
    this.context,
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
    } else if (isStart(flag, SatelliteLinkText.flag)) {
      /// 解析帖子中的帖子链接
      /// 将格式如：'<a href=".*&satellite_id=(\d+)" target=".*" [^>]+>(.*)<\/a>'
      /// 转成'[satelliteLink:{"$satelliteId":"$satelliteTitle"}]'再进行解析
      return SatelliteLinkText(
        textStyle,
        onTap,
        start: index - (SatelliteLinkText.flag.length - 1),
        showAtBackground: showAtBackground,
        type: type,
        linkStyle: linkStyle,
        context: context,
      );
    } else if (isStart(flag, WebViewLinkText.flag)) {
      /// 解析帖子中的webView链接
      /// 将格式如：'<a href="(https?:\/\/.*?)" target=".*" [^>]+>(.*)<\/a>'
      /// 转成[webViewLink:{"$webViewUrl":"$webViewTitle"}]再进行解析
      return WebViewLinkText(
        textStyle,
        onTap,
        start: index - (WebViewLinkText.flag.length - 1),
        showAtBackground: showAtBackground,
        type: type,
        linkStyle: linkStyle,
        context: context,
      );
    }

    return null;
  }
}

enum BuilderType { extendedText, extendedTextField }
