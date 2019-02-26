import 'dart:io';

class AppConst {
  static const img_host = 'https://image.mhxk.com';

  // ios使用jpg格式图片 android使用webp格式图片
  static ImageSizeSuffix imageSizeSuffix =
      ImageSizeSuffix.fromJson(imageSizeSuffixMap);

  static Map<String, String> imageSizeSuffixMap = {
    "h1x1": Platform.isIOS ? "-600x600.jpg" : "-600x600.jpg.webp",
    "m1x1": Platform.isIOS ? "-480x480.jpg" : "-480x480.jpg",
    "l1x1": Platform.isIOS ? "-300x300.jpg" : "-300x300.jpg",
    "h3x4": Platform.isIOS ? "-600x800.jpg" : "-600x800.jpg",
    "m3x4": Platform.isIOS ? "-480x640.jpg" : "-480x640.jpg",
    "l3x4": Platform.isIOS ? "-300x400.jpg" : "-300x400.jpg",
    "h4x3": Platform.isIOS ? "-800x600.jpg" : "-800x600.jpg",
    "m4x3": Platform.isIOS ? "-640x480.jpg" : "-640x480.jpg",
    "l4x3": Platform.isIOS ? "-400x300.jpg" : "-400x300.jpg",
    "h16x7": Platform.isIOS ? "-800x350.jpg" : "-800x350.jpg",
    "m16x7": Platform.isIOS ? "-640x280.jpg" : "-640x280.jpg",
    "l16x7": Platform.isIOS ? "-400x175.jpg" : "-400x175.jpg",
    "h2x1": Platform.isIOS ? "-800x400.jpg" : "-800x400.jpg",
    "m2x1": Platform.isIOS ? "-640x320.jpg" : "-640x320.jpg",
    "l2x1": Platform.isIOS ? "-400x200.jpg" : "-400x200.jpg",
    "h16x9": Platform.isIOS ? "-800x450.jpg" : "-800x450.jpg",
    "m16x9": Platform.isIOS ? "-640x360.jpg" : "-640x360.jpg",
    "l16x9": Platform.isIOS ? "-400x225.jpg" : "-400x225.jpg",
    "head": Platform.isIOS ? "-100x100.webp" : "-100x100.jpg",
    "default": Platform.isIOS ? "-noresize" : "-noresize.webp",
  };

  // android使用webp格式图片
  // static ImageSizeSuffix imageSizeWebp = ImageSizeSuffix.fromJson({
  //   "h1x1": "-500x500.jpg.webp",
  //   "m1x1": "-480x480.jpg.webp",
  //   "l1x1": "-300x300.jpg.webp",
  //   "h3x4": "-600x800.jpg.webp",
  //   "m3x4": "-480x640.jpg.webp",
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
