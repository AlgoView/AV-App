import 'package:flutter/material.dart';
import '../../theme/colors.dart'; // Import AppTheme

class PanelOrder extends StatelessWidget {
	final Color backgroundColor;

	static const double panelWidth = 400.0;

	const PanelOrder({super.key, required this.backgroundColor});

	@override
	Widget build(BuildContext context) {
		return Container(
			color: backgroundColor,
			padding: const EdgeInsets.all(16),
			child: const Center(
				child: Text(
					'Order Panel',
					style: TextStyle(color: AppTheme.activeIconColor),
				),
			),
		);
	}
}
