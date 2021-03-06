import 'dart:io';

class AppConst {
  static const img_host = 'https://image.mhxk.com';
  static const imgNewHost = 'http://image.yqmh.com';
  // static const mhImgHost = 'http://mhpic.mh51.com';
  static const mhImgHost = 'http://mhpic.jumanhua.com';
  static const cmsHost = 'http://cms.samanlehua.com';
  static const userHeadImgHost = 'http://head.samanlehua.com';
  static const commentImgHost = 'https://comment.yyhao.com';

  // ios使用jpg格式图片 android使用webp格式图片
  static ImageSizeSuffix imageSizeSuffix =
      ImageSizeSuffix.fromJson(imageSizeSuffixMap);

  static Map<String, String> imageSizeSuffixMap = {
    "h1x1": Platform.isIOS ? "-600x600.jpg" : "-600x600.jpg.webp",
    "m1x1": Platform.isIOS ? "-480x480.jpg" : "-480x480.jpg.webp",
    "l1x1": Platform.isIOS ? "-300x300.jpg" : "-300x300.jpg.webp",
    "h3x4": Platform.isIOS ? "-600x800.jpg" : "-600x800.jpg.webp",
    "m3x4": Platform.isIOS ? "-480x640.jpg" : "-960x1280.jpg.webp",
    "l3x4": Platform.isIOS ? "-300x400.jpg" : "-300x400.jpg.webp",
    "h4x3": Platform.isIOS ? "-800x600.jpg" : "-800x600.jpg.webp",
    "m4x3": Platform.isIOS ? "-640x480.jpg" : "-640x480.jpg.webp",
    "l4x3": Platform.isIOS ? "-400x300.jpg" : "-400x300.jpg.webp",
    "h16x7": Platform.isIOS ? "-800x350.jpg" : "-800x350.jpg.webp",
    "m16x7": Platform.isIOS ? "-640x280.jpg" : "-640x280.jpg.webp",
    "l16x7": Platform.isIOS ? "-400x175.jpg" : "-400x175.jpg.webp",
    "h2x1": Platform.isIOS ? "-800x400.jpg" : "-800x400.jpg.webp",
    "m2x1": Platform.isIOS ? "-640x320.jpg" : "-640x320.jpg.webp",
    "l2x1": Platform.isIOS ? "-400x200.jpg" : "-400x200.jpg.webp",
    "h16x9": Platform.isIOS ? "-800x450.jpg" : "-800x450.jpg.webp",
    "m16x9": Platform.isIOS ? "-640x360.jpg" : "-640x360.jpg.webp",
    "l16x9": Platform.isIOS ? "-400x225.jpg" : "-400x225.jpg.webp",
    "head": Platform.isIOS ? "-100x100" : "-100x100.webp",
    "default": Platform.isIOS ? "-noresize" : "-noresize.webp",
  };

  /// 匹配所有支持短信功能的号码（手机卡 + 上网卡）
  static RegExp phoneReg = RegExp(
      r'^(?:\+?86)?1(?:3\d{3}|5[^4\D]\d{2}|8\d{3}|7(?:[01356789]\d{2}|4(?:0\d|1[0-2]|9\d))|9[189]\d{2}|6[567]\d{2}|4[579]\d{2})\d{6}$');

  static Map<int, String> weekdayString = {
    0: '周日',
    1: '周一',
    2: '周二',
    3: '周三',
    4: '周四',
    5: '周五',
    6: '周六',
  };

  // android使用webp格式图片
  // static ImageSizeSuffix imageSizeWebp = ImageSizeSuffix.fromJson({
  //   "h1x1": "-500x500.jpg.webp",
  //   "m1x1": "-480x480.jpg.webp",
  //   "l1x1": "-300x300.jpg.webp",
  //   "h3x4": "-600x800.jpg.webp",
  //   "m3x4": "-960x1280.jpg.webp",
  //   "l3x4": "-300x400.jpg.webp",
  //   "h4x3": "-800x600.jpg.webp",
  //   "m4x3": "-640x480.jpg.webp",
  //   "l4x3": "-400x300.jpg.webp",
  //   "h16x7": "-800x350.jpg.webp",
  //   "m16x7": "-640x280.jpg.webp",
  //   "l16x7": "-400x175.jpg.webp",
  //   "h2x1": "-800x400.jpg.webp",
  //   "m2x1": "-640x320.jpg.webp",
  //   "l2x1": "-400x200.jpg.webp",
  //   "h16x9": "-800x450.jpg.webp",
  //   "m16x9": "-640x360.jpg.webp",
  //   "l16x9": "-400x225.jpg.webp",
  //   "head_webp": "-100x100.webp",
  //   "default_webp": "-noresize.webp"
  // });

  static const emojiMap = {
    '[/奋斗]': 'lib/images/emojis/face01.png',
    '[/鼓掌]': 'lib/images/emojis/face02.png',
    '[/发怒]': 'lib/images/emojis/face03.png',
    '[/色]': 'lib/images/emojis/face04.png',
    '[/给力]': 'lib/images/emojis/face05.png',
    '[/憨笑]': 'lib/images/emojis/face06.png',
    '[/可爱]': 'lib/images/emojis/face07.png',
    '[/抓狂]': 'lib/images/emojis/face08.png',
    '[/流汗]': 'lib/images/emojis/face09.png',
    '[/强]': 'lib/images/emojis/face10.png',
    '[/弱]': 'lib/images/emojis/face11.png',
    '[/玫瑰]': 'lib/images/emojis/face12.png',
    '[/大哭]': 'lib/images/emojis/face13.png',
    '[/疑问]': 'lib/images/emojis/face14.png',
    '[/鄙视]': 'lib/images/emojis/face15.png',
    '[/钱]': 'lib/images/emojis/face16.png',
    '[/闭嘴]': 'lib/images/emojis/face17.png',
    '[/可怜]': 'lib/images/emojis/face18.png',
    '[/惊讶]': 'lib/images/emojis/face19.png',
    '[/浮云]': 'lib/images/emojis/face20.png',
    '[/打酱油]': 'lib/images/emojis/face21.png',
    '[/握手]': 'lib/images/emojis/face22.png',
    '[/拳头]': 'lib/images/emojis/face23.png',
    '[/返回]': 'lib/images/emojis/back.png',
  };
}

class ImageSizeSuffix {
  final String h1x1;
  final String m1x1;
  final String l1x1;
  final String h3x4;
  final String m3x4;
  final String l3x4;
  final String h4x3;
  final String m4x3;
  final String l4x3;
  final String h16x7;
  final String m16x7;
  final String l16x7;
  final String h2x1;
  final String m2x1;
  final String l2x1;
  final String h16x9;
  final String m16x9;
  final String l16x9;
  final String head;
  final String defaultSuffix;

  ImageSizeSuffix.fromJson(Map<String, String> json)
      : h1x1 = json['h1x1'],
        m1x1 = json['m1x1'],
        l1x1 = json['l1x1'],
        h3x4 = json['h3x4'],
        m3x4 = json['m3x4'],
        l3x4 = json['l3x4'],
        h4x3 = json['h4x3'],
        m4x3 = json['m4x3'],
        l4x3 = json['l4x3'],
        h16x7 = json['h16x7'],
        m16x7 = json['m16x7'],
        l16x7 = json['l16x7'],
        h2x1 = json['h2x1'],
        m2x1 = json['m2x1'],
        l2x1 = json['l2x1'],
        h16x9 = json['h16x9'],
        m16x9 = json['m16x9'],
        l16x9 = json['l16x9'],
        head = json['head'],
        defaultSuffix = json['default'];
}
