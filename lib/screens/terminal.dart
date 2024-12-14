import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/bar_bottom.dart';
import '../widgets/bar_side.dart';
import '../widgets/panel_order.dart';
import '../widgets/panel_positions.dart';
import '../widgets/panel_wallet.dart';
import '../utils/manager_drag.dart';
import '../theme/colors.dart';

class TerminalScreen extends StatefulWidget {
	const TerminalScreen({Key? key}) : super(key: key);

	@override
	State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
	final ManagerDrag _dragManager = ManagerDrag();

	bool showOrderPanel = false;
	bool showWalletPanel = false;
	bool showPositionsPanel = true;
	double bottomPanelHeight = 200;
	bool isSidebarOnRight = false;
	Offset _tapPosition = Offset.zero;

	// Hover/Highlight state
	bool _isHoverHighlight = false;

	@override
	void dispose() {
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		double maxBottomPanelHeight =
				MediaQuery.of(context).size.height - BarBottom.height - BarBottom.dragAreaHeight;

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
					// Main Background
					Positioned.fill(
						child: Container(color: AppTheme.backgroundColor),
					),

					// Bottom Panel
					if (bottomPanelHeight > 0)
						Positioned(
							left: 0,
							right: 0,
							bottom: BarBottom.height,
							height: bottomPanelHeight,
							child: PanelPositions(
								height: bottomPanelHeight,
							),
						),

					// Draggable Area
					Positioned(
						left: 0,
						right: 0,
						bottom: bottomPanelHeight + BarBottom.height,
						height: BarBottom.dragAreaHeight,
						child: MouseRegion(
							cursor: SystemMouseCursors.resizeRow,
							onEnter: (_) => _dragManager.manageHover(true, (isHighlight) {
								setState(() => _isHoverHighlight = isHighlight);
							}),
							onExit: (_) => _dragManager.manageHover(false, (isHighlight) {
								setState(() => _isHoverHighlight = isHighlight);
							}),
							child: GestureDetector(
								behavior: HitTestBehavior.translucent,
								onPanStart: (details) {
									_dragManager.onDragStart(details.globalPosition.dy);
									setState(() => _isHoverHighlight = true);
								},
								onPanUpdate: (details) {
									setState(() {
										bottomPanelHeight = _dragManager.handleDrag(
											details.globalPosition.dy.toDouble(),
											bottomPanelHeight,
											maxBottomPanelHeight,
										);
										showPositionsPanel = bottomPanelHeight > 0;
									});
								},
								onPanEnd: (_) {
									_dragManager.onDragEnd(
										bottomPanelHeight,
										(newHeight, isVisible) {
											setState(() {
												bottomPanelHeight = newHeight.toDouble();
												showPositionsPanel = isVisible;
											});
										},
									);
								},
								child: AnimatedContainer(
									duration: _dragManager.isDragging
											? Duration.zero
											: const Duration(milliseconds: 200),
									color: (_dragManager.isDragging || _isHoverHighlight)
											? AppTheme.highlightColor
											: Colors.transparent,
								),
							),
						),
					),

					// Bottom Bar
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
			width: 300,
			decoration: BoxDecoration(
				color: AppTheme.panelColor,
				border: Border(
					left: isSidebarOnRight ? BorderSide(color: AppTheme.panelBorderColor, width: 1) : BorderSide.none,
					right: isSidebarOnRight ? BorderSide.none : BorderSide(color: AppTheme.panelBorderColor, width: 1),
				),
			),
			child: Column(
				children: [
					if (showOrderPanel)
						Expanded(
							flex: showWalletPanel ? 1 : 2,
							child: PanelOrder(backgroundColor: AppTheme.panelColor),
						),
					if (showOrderPanel && showWalletPanel)
						Divider(color: AppTheme.panelBorderColor, height: 1),
					if (showWalletPanel)
						Expanded(
							flex: showOrderPanel ? 1 : 2,
							child: PanelWallet(backgroundColor: AppTheme.panelColor),
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
				PopupMenuItem(
					value: "left",
					child: const Text("Move Sidebar to Left"),
				),
				PopupMenuItem(
					value: "right",
					child: const Text("Move Sidebar to Right"),
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
