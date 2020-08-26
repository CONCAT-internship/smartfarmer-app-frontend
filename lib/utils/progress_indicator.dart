import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final double containerSize;
  final double progressSize;

  const ProgressIndicator({
    Key key, this.containerSize, this.progressSize = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      child: Center(
        child: SizedBox(
          width: progressSize,
          height: progressSize,
          child: Image.asset('assets/images/loading.gif'),
        ),
      ),
    );
  }
}
