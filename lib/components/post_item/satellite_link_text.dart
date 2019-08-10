import 'dart:convert';

import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_manhuatai/routes/application.dart';
import 'package:flutter_manhuatai/routes/routes.dart';

import 'post_special_text_span_builder.dart';

/// 解析如下格式
/// '[satelliteLink:{"$satelliteId":"$satelliteTitle"}]';
class SatelliteLinkText extends SpecialText {
  static const String flag = "[satelliteLink:";
  final int start;
  final BuildContext context;

  /// whether show background for @somebody
  final bool showAtBackground;

  final BuilderType type;
  final TextStyle linkStyle;
  // final VoidCallback selfTap;

  SatelliteLinkText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback onTap, {
    this.showAtBackground = false,
    this.type,
    this.start,
    this.linkStyle,
    this.context,
    // this.selfTap,
  }) : super(flag, "]", textStyle, onTap: onTap);

  @override
  TextSpan finishText() {
    TextStyle textStyle =
        this.textStyle?.copyWith(color: Colors.blue, fontSize: 16.0);

    // 格式如：'[satelliteLink:{"$satelliteId":"$satelliteTitle"}]';
    final String content = getContent();
    Map<String, dynamic> satelliteInfo = json.decode(content);
    String satelliteId = satelliteInfo.keys.first;
    String satelliteTitle = satelliteInfo.values.first;

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: satelliteTitle,
            actualText: satelliteTitle,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: linkStyle ?? textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () async {
                    await Application.router.navigateTo(context,
                        '${Routes.satelliteDetail}?satelliteId=$satelliteId');
                  })
                : null,
          )
        : SpecialTextSpan(
            text: satelliteTitle,
            actualText: satelliteTitle,
            start: start,
            style: linkStyle ?? textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () async {
                    await Application.router.navigateTo(context,
                        '${Routes.satelliteDetail}?satelliteId=$satelliteId');
                  })
                : null,
          );
  }
}
