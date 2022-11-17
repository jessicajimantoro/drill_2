import 'package:flutter/material.dart';

class CustomSliverIntrinsicGrid extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;

  const CustomSliverIntrinsicGrid({
    Key? key,
    this.crossAxisCount = 1,
    this.children = const [], 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < crossAxisCount; i++)
                  (index * crossAxisCount + i != children.length)
                      ? Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: children[index * 2 + i]),
                        )
                      : const Expanded(
                          child: SizedBox.shrink(),
                        ),
              ],
            ),
          );
        },
        childCount: (children.length / crossAxisCount).ceil(),
      ),
    );
  }
}
