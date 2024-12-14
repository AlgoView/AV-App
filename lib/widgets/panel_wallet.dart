import 'package:flutter/material.dart';
import '../theme/colors.dart'; // Import AppTheme

class PanelWallet extends StatelessWidget {
  final Color backgroundColor;

  const PanelWallet({Key? key, required this.backgroundColor}) : super(key: key);

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
