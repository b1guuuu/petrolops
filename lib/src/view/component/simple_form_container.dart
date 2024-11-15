import 'package:flutter/material.dart';

class SimpleFormContainer extends StatelessWidget {
  final Widget child;
  final int numFieds;
  final double _fieldHeight = 150;
  final double _maxHeight = 600;
  final double _maxWidth = 700;

  const SimpleFormContainer(
      {super.key, required this.numFieds, required this.child});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Center(
        child: SizedBox(
          height: _fieldHeight * numFieds > _maxHeight
              ? _maxHeight
              : _fieldHeight * numFieds,
          width: _maxWidth,
          child: child,
        ),
      ),
    );
  }
}
