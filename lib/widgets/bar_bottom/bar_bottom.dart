import 'package:flutter/material.dart';
import '../../theme/colors.dart';

// Hardcoded variables
const double barHeight = 45;
const double dragAreaHeight = 5;

class BarBottom extends StatelessWidget {
	final bool isActive;
	final Color activeColor;
	final Color inactiveColor;
	final VoidCallback onToggle;

	const BarBottom({
		super.key,
		required this.isActive,
		required this.activeColor,
		required this.inactiveColor,
		required this.onToggle,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			height: barHeight,
			decoration: const BoxDecoration(
				color: AppTheme.panelColor,
				border: Border(
					top: BorderSide(color: AppTheme.panelBorderColor, width: 1),
				),
			),
			child: Row(
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