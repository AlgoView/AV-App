import 'package:flutter/material.dart';

class PanelPositions extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final Color borderColor;

  const PanelPositions({
    Key? key,
    required this.height,
    required this.backgroundColor,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: Text(
          'Positions Panel',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
