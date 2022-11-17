import 'package:flutter/material.dart';

class CustomSliverGrid extends StatelessWidget {
  final SliverGridDelegate? sliverGridDelegate;
  final int itemCount;
  final List<Widget> Function(int index) widget;

  const CustomSliverGrid({
    Key? key,
    required this.widget,
    this.itemCount = 0,
    this.sliverGridDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: sliverGridDelegate ??
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Flex(
            direction: Axis.vertical,
            children: widget.call(index),
          );
        },
        childCount: itemCount,
      ),
    );
  }
}
