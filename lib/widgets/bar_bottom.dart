import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BarBottom extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onToggle;

  static const double height = 45; // Static constant
  static const double dragAreaHeight = 5; // Static constant

  const BarBottom({
    Key? key,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onToggle,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.list_alt,
              color: isActive ? activeColor : inactiveColor,
            ),
            onPressed: onToggle,
          ),
        ],
      ),
    );
  }
}
