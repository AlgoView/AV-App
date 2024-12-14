import 'package:flutter/material.dart';
import '../theme/colors.dart'; // Import AppTheme

class PanelPositions extends StatelessWidget {
  final double height;

  static const double minHeight = 100; // Static constant

  const PanelPositions({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.panelColor,
        border: Border(
          top: BorderSide(color: AppTheme.panelBorderColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: Text(
          'Positions Panel',
          style: TextStyle(color: AppTheme.activeIconColor),
        ),
      ),
    );
  }
}
