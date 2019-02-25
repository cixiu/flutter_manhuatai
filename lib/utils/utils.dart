class Utils {
  // 计算图片的显示规格，通过 16:9 形式的字符串，计算成一个数字比例
  static double computedRatio(String horizonRatio) {
    List<String> ratioList = horizonRatio.split(':');
    int widthRatio = int.parse(ratioList[0]);
    int heightRatio = int.parse(ratioList[1]);

    return widthRatio / heightRatio;
  }
}
