import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BarSide extends StatelessWidget {
  final bool isRightAligned;
  final bool isOrderPanelVisible;
  final bool isWalletPanelVisible;
  final VoidCallback toggleOrderPanel;
  final VoidCallback toggleWalletPanel;
  final Color activeColor;
  final Color inactiveColor;
  final Color panelColor;
  final Color panelBorderColor;
  static const double width = 50;
  static const double panelWidth = 300.0;

  const BarSide({
    Key? key,
    required this.isRightAligned,
    required this.isOrderPanelVisible,
    required this.isWalletPanelVisible,
    required this.toggleOrderPanel,
    required this.toggleWalletPanel,
    required this.activeColor,
    required this.inactiveColor,
    required this.panelColor,
    required this.panelBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: panelColor,
        border: Border(
          left: isRightAligned
              ? BorderSide(color: panelBorderColor, width: 1)
              : BorderSide.none,
          right: isRightAligned
              ? BorderSide.none
              : BorderSide(color: panelBorderColor, width: 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: isOrderPanelVisible ? activeColor : inactiveColor,
            onPressed: toggleOrderPanel,
          ),
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            color: isWalletPanelVisible ? activeColor : inactiveColor,
            onPressed: toggleWalletPanel,
          ),
        ],
      ),
    );
  }
}

