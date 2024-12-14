import 'package:flutter/material.dart';

class BarBottom extends StatelessWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onToggle;

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
      decoration: BoxDecoration(
        color: Colors.black, // Adjust based on your theme
        border: Border(
          top: BorderSide(color: Colors.grey.shade700, width: 1),
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
