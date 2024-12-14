import 'package:flutter/material.dart';
import '../widgets/bar_bottom/bar_bottom.dart';
import '../widgets/bar_side/bar_side.dart';
import '../widgets/bar_side/panel_order.dart';
import '../widgets/bar_bottom/panel_positions.dart';
import '../widgets/bar_side/panel_wallet.dart';
import '../theme/colors.dart';

class TerminalScreen extends StatefulWidget {
	const TerminalScreen({super.key});

	@override
	State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
	bool showOrderPanel = false;
	bool showWalletPanel = false;
	bool showPositionsPanel = true;
	double bottomPanelHeight = 200;
	bool isSidebarOnRight = false;
	Offset _tapPosition = Offset.zero;

	@override
	Widget build(BuildContext context) {
		double maxBottomPanelHeight = MediaQuery.of(context).size.height - 100;

		List<Widget> layoutChildren = isSidebarOnRight
				? [
						_buildMainContent(maxBottomPanelHeight),
						if (showOrderPanel || showWalletPanel) _buildSidePanelContainer(),
						_buildSidebar(),
					]
				: [
						_buildSidebar(),
						if (showOrderPanel || showWalletPanel) _buildSidePanelContainer(),
						_buildMainContent(maxBottomPanelHeight),
					];

		return Scaffold(
			body: SafeArea(
				child: Column(
					children: [
						Expanded(
							child: Row(children: layoutChildren),
						),
					],
				),
			),
		);
	}

	Widget _buildMainContent(double maxBottomPanelHeight) {
		return Expanded(
			child: Stack(
				children: [
					Positioned.fill(
						child: Container(color: AppTheme.backgroundColor),
					),
					if (showPositionsPanel)
						PanelPositions(
							initialHeight: bottomPanelHeight,
							maxHeight: maxBottomPanelHeight,
							onHeightChanged: (newHeight) {
								setState(() => bottomPanelHeight = newHeight);
							},
						),
					Positioned(
						left: 0,
						right: 0,
						bottom: 0,
						child: BarBottom(
							isActive: showPositionsPanel,
							activeColor: AppTheme.activeIconColor,
							inactiveColor: AppTheme.inactiveIconColor,
							onToggle: _togglePositionsPanel,
						),
					),
				],
			),
		);
	}

	Widget _buildSidebar() {
		return GestureDetector(
			onSecondaryTapDown: (details) {
				_tapPosition = details.globalPosition;
			},
			onSecondaryTap: _showContextMenu,
			child: BarSide(
				isRightAligned: isSidebarOnRight,
				isOrderPanelVisible: showOrderPanel,
				isWalletPanelVisible: showWalletPanel,
				toggleOrderPanel: _toggleOrderPanel,
				toggleWalletPanel: _toggleWalletPanel,
				activeColor: AppTheme.activeIconColor,
				inactiveColor: AppTheme.inactiveIconColor,
				panelColor: AppTheme.panelColor,
				panelBorderColor: AppTheme.panelBorderColor,
			),
		);
	}

	Widget _buildSidePanelContainer() {
		return Container(
			width: showOrderPanel
					? PanelOrder.panelWidth
					: PanelWallet.panelWidth,
			decoration: BoxDecoration(
				color: AppTheme.panelColor,
				border: Border(
					left: isSidebarOnRight ? const BorderSide(color: AppTheme.panelBorderColor, width: 1) : BorderSide.none,
					right: isSidebarOnRight ? BorderSide.none : const BorderSide(color: AppTheme.panelBorderColor, width: 1),
				),
			),
			child: Column(
				children: [
					if (showOrderPanel)
						Expanded(
							flex: showWalletPanel ? 1 : 2,
							child: const PanelOrder(backgroundColor: AppTheme.panelColor),
						),
					if (showOrderPanel && showWalletPanel)
						const Divider(color: AppTheme.panelBorderColor, height: 1),
					if (showWalletPanel)
						Expanded(
							flex: showOrderPanel ? 1 : 2,
							child: const PanelWallet(backgroundColor: AppTheme.panelColor),
						),
				],
			),
		);
	}

	void _toggleOrderPanel() {
		setState(() {
			showOrderPanel = !showOrderPanel;
			if (showOrderPanel) showWalletPanel = false;
		});
	}

	void _toggleWalletPanel() {
		setState(() {
			showWalletPanel = !showWalletPanel;
			if (showWalletPanel) showOrderPanel = false;
		});
	}

	void _togglePositionsPanel() {
		setState(() {
			if (showPositionsPanel) {
				bottomPanelHeight = 0;
				showPositionsPanel = false;
			} else {
				bottomPanelHeight = PanelPositions.minHeight;
				showPositionsPanel = true;
			}
		});
	}

	void _showContextMenu() {
		final size = MediaQuery.of(context).size;
		showMenu(
			context: context,
			position: RelativeRect.fromLTRB(
				_tapPosition.dx,
				_tapPosition.dy,
				size.width - _tapPosition.dx,
				size.height - _tapPosition.dy,
			),
			items: [
				const PopupMenuItem(
					value: "left",
					child: Text("Move Sidebar to Left"),
				),
				const PopupMenuItem(
					value: "right",
					child: Text("Move Sidebar to Right"),
				),
			],
		).then((value) {
			if (value == "left") {
				setState(() {
					isSidebarOnRight = false;
				});
			} else if (value == "right") {
				setState(() {
					isSidebarOnRight = true;
				});
			}
		});
	}
}
