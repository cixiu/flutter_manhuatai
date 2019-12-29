import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class TaskTabView extends StatefulWidget {
  final String positionKey;
  final String name;

  TaskTabView({
    this.positionKey,
    this.name,
  });

  @override
  _TaskTabViewState createState() => _TaskTabViewState();
}

class _TaskTabViewState extends State<TaskTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key('${widget.positionKey}'),
      ListView(
        children: List.generate(100, (index) {
          return Text('${widget.name} $index');
        }),
      ),
    );
  }
}
