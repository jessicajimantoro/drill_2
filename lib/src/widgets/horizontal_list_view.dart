import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  final double height;
  final int itemCount;
  final Widget Function(int index) widget;

  const HorizontalListView({
    Key? key,
    this.height = 160.0,
    this.itemCount = 0,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) => widget.call(index),
      ),
    );
  }
}
