import 'package:flutter/material.dart';

/// 通用的下拉刷新和上拉加载更多组件
class PullLoadWrapper extends StatefulWidget {
  /// 下拉刷新的 key
  final Key refreshKey;

  /// 控制页面的上拉和下拉的配置和一些数据的改变
  final PullLoadWrapperControl control;

  final bool isFirstLoading;

  /// ListView.builder 中的 itemBuilder
  final IndexedWidgetBuilder itemBuilder;

  /// 上拉加载更多的回调
  final RefreshCallback onLoadMore;

  /// 下拉刷新的回调
  final RefreshCallback onRefresh;

  PullLoadWrapper({
    this.control,
    this.refreshKey,
    this.isFirstLoading,
    this.itemBuilder,
    this.onLoadMore,
    this.onRefresh,
  });

  @override
  _PullLoadWrapperState createState() => _PullLoadWrapperState();
}

class _PullLoadWrapperState extends State<PullLoadWrapper> {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // 滚动监听
    _scrollController.addListener(() {
      // 判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.control.needLoadMore) {
          assert(widget.onLoadMore != null);
          widget.onLoadMore();
        }
      }
    });
    super.initState();
  }

  /// ListView.builder 中的 itemCount 参数
  /// 需要根据配置动态处理具体返回多少数值
  /// 是否加载头部，加载更多，空页面
  int _getListCount() {
    var dataListLength = widget.control.dataListLength;
    // 是否需要头部
    if (widget.control.needHeader) {
      // 如果需要头部，则使用第一个 Item 的 Widget作为 ListView.builder 的头部
      // 当列表的数量大于0时，因为需要头部和加载更多的组件，所以需要对列表的数据总数+2
      return dataListLength > 0 ? dataListLength + 2 : dataListLength + 1;
    } else {
      // 如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (dataListLength == 0) {
        return 1;
      }

      // 如果不需要头部，且有数据，因为需要加载更多的组件，所以需要对列表的数据总数+1
      return dataListLength > 0 ? dataListLength + 1 : dataListLength;
    }
  }

  /// ListView.builder 中的 itemBuilder
  /// 需要根据配置返回实际列表渲染Item
  Widget _getItem(BuildContext context, int index) {
    // 如果不需要头部，且数据不为0，当 index 等于数据长度时，渲染加载更多组件
    if (!widget.control.needHeader &&
        index == widget.control.dataListLength &&
        widget.control.dataListLength != 0) {
      return _buildProgressIndicator();
    }
    // 如果不需要头部，且数据为0，渲染空页面
    if (!widget.control.needHeader && widget.control.dataListLength == 0) {
      return Container(
        child: Text('没有发现数据哦~~'),
      );
    }
    // 如果需要头部，且数据不为0，当 index 等于实际渲染长度 - 1时，渲染加载更多组件
    if (widget.control.needHeader &&
        index == _getListCount() - 1 &&
        widget.control.dataListLength != 0) {
      return _buildProgressIndicator();
    }

    // 回调外正常渲染Item
    return widget.itemBuilder(context, index);
  }

  //
  Widget _buildProgressIndicator() {
    TextStyle textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14.0,
    );
    // 根据是否需要加载更多控制底部的显示 widget
    Widget bottomWidget = widget.control.needLoadMore
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10.0),
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              Text(
                '正在加载...',
                style: textStyle,
              ),
            ],
          )
        : Container(
            height: 20.0,
            child: Text(
              '小主没有更多了呢！',
              style: textStyle,
            ),
          );

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: bottomWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // GlobalKey，用户外部获取RefreshIndicator的State，做显示
      key: widget.refreshKey,
      // 下拉刷新触发
      onRefresh: widget.onRefresh,
      child: widget.isFirstLoading
          ? Container()
          : ListView.builder(
              // 保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
              physics: AlwaysScrollableScrollPhysics(),
              //
              itemBuilder: (context, index) {
                return _getItem(context, index);
              },
              //
              itemCount: _getListCount(),
              // 滚动监听
              controller: _scrollController,
            ),
    );
  }
}

/// 用于控制页面级别的组件的一些控制器活着配置
class PullLoadWrapperControl {
  /// 上拉加载更多的列表数据
  // List dataList = [];

  // 列表数据的长度
  int dataListLength = 0;

  /// 是否需要加载更多
  bool needLoadMore = false;

  /// 是否需要头部
  bool needHeader = false;
}
