import 'package:flutter/material.dart';
import '../../theme/colors.dart'; // Import AppTheme

class PanelWallet extends StatelessWidget {
	final Color backgroundColor;

	static const double panelWidth = 300.0;

	const PanelWallet({super.key, required this.backgroundColor});

	@override
	Widget build(BuildContext context) {
		return Container(
			color: backgroundColor,
			padding: const EdgeInsets.all(16),
			child: const Center(
				child: Text(
					'Wallet Panel',
					style: TextStyle(color: AppTheme.activeIconColor),
				),
			),
		);
	}
}
