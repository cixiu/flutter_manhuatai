# flutter_manhuatai

一个使用 Flutter 开发的一款漫画阅读 App, 相应的微信小程序地址 [漫画台小程序](https://github.com/cixiu/manhuatai-miniapp).

## Getting Started

```bash
# clone project
git clone git@github.com:cixiu/flutter_manhuatai.git

# cd project root directory
cd flutter_manhuatai

# install dependencies
flutter packages get

# run project
flutter run
```

## Problems encountered

1. [FloatingActionButton 的 heroTag 必须唯一， 或者为 null](https://stackoverflow.com/questions/53265299/flutter-gridview-causes-navigator-push-error)
2. [Widgets in the overflow of stack do not respond to gestures](https://github.com/flutter/flutter/issues/19445)
3. [手机适配问题-Flutter screen adaptation, font adaptation, get screen information](https://github.com/OpenFlutter/flutter_screenutil)
4. [嵌套的 ScrollView 问题(NestedScrollView, 吸顶 TabBar),解决方法](https://github.com/fluttercandies/extended_nested_scroll_view)
5. [嵌套的 ScrollView+下拉上拉加载更多之解决方法](https://github.com/fluttercandies/loading_more_list)
6. 如果使用 Text Widget 对中文设置字体大小后，在一个 Container 容器中字体不居中的问题，使用 strutStyle 的 forceStrutHeight 强制 lineHeight 与字体的高度一致，解决字体在容器中不居中的问题

```dart
child: Text(
  item.name,
  strutStyle: StrutStyle(
    fontSize: ScreenUtil().setSp(20),
    forceStrutHeight: true,
  ),
  style: TextStyle(
    color: Colors.white,
    fontSize: ScreenUtil().setSp(20),
  ),
),
```

7. [borderRadius 必须有统一的 border 才能设置](https://github.com/flutter/flutter/issues/12583)
8. [border 属性不支持 dashed(虚线)设置，需要自己绘制](https://github.com/flutter/flutter/issues/4858)
9. [Flutter 真机(魅族)开发卡在 Installing build\app\outputs\apk\app.apk 的问题](https://blog.csdn.net/donkor_/article/details/82972790)
   - 解决方法： 开发者选项 -> 性能优化 -> 高级日志输出 -> 全部允许
