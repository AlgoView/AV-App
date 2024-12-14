import 'dart:async';
import 'package:flutter/material.dart';

class TerminalScreen extends StatefulWidget {
	const TerminalScreen({Key? key}) : super(key: key);

	@override
	State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
	// Look and feel control variables
	final double minBottomPanelHeight = 100;
	final double collapseThreshold = 50.0;
	final double initialBottomPanelHeight = 200;
	final double bottomBarHeight = 40;
	final double dragAreaHeight = 4;
	final double sidebarWidth = 50;
	final double sidePanelContainerWidth = 300;
	final double hoverDelayMilliseconds = 200;
	final Color backgroundColor = const Color.fromARGB(255, 31, 31, 31);
	final Color panelColor = const Color.fromARGB(255, 24, 24, 24).withOpacity(1);
	final Color panelBorderColor = const Color.fromARGB(255, 40, 40, 40);
	final Color highlightColor = Colors.blue;
	final Color activeIconColor = Colors.white;
	final Color inactiveIconColor = Colors.white54;
	final Color dividerColor = const Color.fromARGB(255, 54, 54, 54);

	// State variables
	bool showOrderPanel = false;
	bool showWalletPanel = false;
	bool showPositionsPanel = true;
	bool isSidebarOnRight = false;
	double bottomPanelHeight = 200;
	bool isDragging = false;
	bool isHovered = false;
	double dragStartY = 0;
	Offset _tapPosition = Offset.zero;

	Timer? hoverTimer;

	@override
	void dispose() {
		hoverTimer?.cancel();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		bool sidePanelVisible = showOrderPanel || showWalletPanel;
		double maxBottomPanelHeight =
			MediaQuery.of(context).size.height - bottomBarHeight - sidebarWidth;

		List<Widget> layoutChildren = isSidebarOnRight
			? [
				_buildMainContent(maxBottomPanelHeight),
				if (sidePanelVisible) _buildSidePanelContainer(),
				_buildSidebar(),
			]
			: [
				_buildSidebar(),
				if (sidePanelVisible) _buildSidePanelContainer(),
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
						child: Container(color: backgroundColor),
					),
					if (showPositionsPanel) ...[
						Positioned(
							left: 0,
							right: 0,
							bottom: bottomPanelHeight + bottomBarHeight,
							height: dragAreaHeight,
							child: MouseRegion(
								cursor: SystemMouseCursors.resizeRow,
								onEnter: (_) {
									if (!isDragging) {
										hoverTimer = Timer(Duration(milliseconds: hoverDelayMilliseconds.toInt()), () {
											if (mounted) {
												setState(() {
													isHovered = true;
												});
											}
										});
									}
								},
								onExit: (_) {
									if (!isDragging) {
										hoverTimer?.cancel();
										setState(() {
											isHovered = false;
										});
									}
								},
								child: GestureDetector(
									behavior: HitTestBehavior.translucent,
									onPanStart: (details) {
										hoverTimer?.cancel();
										setState(() {
											isDragging = true;
											isHovered = true;
											dragStartY = details.globalPosition.dy;
										});
									},
									onPanEnd: (_) {
										setState(() {
											isDragging = false;
										});
									},
									onPanCancel: () {
										setState(() {
											isDragging = false;
										});
									},
									onPanUpdate: (details) {
										setState(() {
											double dragDelta = dragStartY - details.globalPosition.dy;
											dragStartY = details.globalPosition.dy;
											bottomPanelHeight += dragDelta;
											if (bottomPanelHeight < minBottomPanelHeight - collapseThreshold) {
												showPositionsPanel = false;
												bottomPanelHeight = minBottomPanelHeight;
											} else if (bottomPanelHeight >= minBottomPanelHeight) {
												showPositionsPanel = true;
												bottomPanelHeight = bottomPanelHeight.clamp(minBottomPanelHeight, maxBottomPanelHeight);
											}
										});
									},
									child: AnimatedOpacity(
										opacity: isDragging || isHovered ? 1.0 : 0.0,
										duration: const Duration(milliseconds: 200),
										child: Container(
											color: highlightColor,
										),
									),
								),
							),
						),
						Positioned(
							left: 0,
							right: 0,
							bottom: bottomBarHeight,
							height: bottomPanelHeight,
							child: _buildBottomPositionsPanel(),
						),
					],
					Positioned(
						left: 0,
						right: 0,
						bottom: 0,
						height: bottomBarHeight,
						child: _buildBottomBar(),
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
			onSecondaryTap: () {
				_showContextMenu();
			},
			child: Container(
				width: sidebarWidth,
				padding: const EdgeInsets.only(top: 5),
				decoration: BoxDecoration(
					color: panelColor,
					border: Border(
						left: isSidebarOnRight ? BorderSide(color: panelBorderColor, width: 1) : BorderSide.none,
						right: isSidebarOnRight ? BorderSide.none : BorderSide(color: panelBorderColor, width: 1),
					),
				),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children: [
						IconButton(
							icon: const Icon(Icons.shopping_cart),
							color: showOrderPanel ? activeIconColor : inactiveIconColor,
							onPressed: () {
								setState(() {
									showOrderPanel = !showOrderPanel;
									if (showOrderPanel) {
										showWalletPanel = false;
									}
								});
							},
						),
						const SizedBox(height: 10),
						IconButton(
							icon: const Icon(Icons.account_balance_wallet),
							color: showWalletPanel ? activeIconColor : inactiveIconColor,
							onPressed: () {
								setState(() {
									showWalletPanel = !showWalletPanel;
									if (showWalletPanel) {
										showOrderPanel = false;
									}
								});
							},
						),
					],
				),
			),
		);
	}

	Widget _buildSidePanelContainer() {
		return Container(
			width: sidePanelContainerWidth,
			decoration: BoxDecoration(
				color: panelColor,
				border: Border(
					left: isSidebarOnRight ? BorderSide(color: panelBorderColor, width: 1) : BorderSide.none,
					right: isSidebarOnRight ? BorderSide.none : BorderSide(color: panelBorderColor, width: 1),
				),
			),
			child: _buildSidePanel(),
		);
	}

	Widget _buildSidePanel() {
		return Column(
			children: [
				if (showOrderPanel)
					Expanded(
						flex: showWalletPanel ? 1 : 2,
						child: _buildOrderPanel(),
					),
				if (showOrderPanel && showWalletPanel)
					Divider(height: 1, color: dividerColor),
				if (showWalletPanel)
					Expanded(
						flex: showOrderPanel ? 1 : 2,
						child: _buildWalletPanel(),
					),
			],
		);
	}

	Widget _buildOrderPanel() {
		return Container(
			padding: const EdgeInsets.all(16),
			color: panelColor,
			child: const Center(
				child: Text(
					'Order Form Panel',
					style: TextStyle(color: Colors.white),
				),
			),
		);
	}

	Widget _buildWalletPanel() {
		return Container(
			padding: const EdgeInsets.all(16),
			color: panelColor,
			child: const Center(
				child: Text(
					'Wallet Panel',
					style: TextStyle(color: Colors.white),
				),
			),
		);
	}

	Widget _buildBottomPositionsPanel() {
		return Container(
			decoration: BoxDecoration(
				color: panelColor,
				border: Border(
					top: BorderSide(color: panelBorderColor, width: 1),
				),
			),
			padding: const EdgeInsets.all(16),
			child: const Center(
				child: Text(
					'Positions Panel',
					style: TextStyle(color: Colors.white),
				),
			),
		);
	}

	Widget _buildBottomBar() {
		return Container(
			decoration: BoxDecoration(
				color: panelColor,
				border: Border(
					top: BorderSide(color: panelBorderColor, width: 1),
				),
			),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.start, // Align icons to the left
				children: [
					IconButton(
						icon: Icon(
							Icons.list_alt, // Keep a consistent icon
							color: showPositionsPanel ? activeIconColor : inactiveIconColor,
						),
						onPressed: () {
							setState(() {
								showPositionsPanel = !showPositionsPanel;
							});
						},
					),
				],
			),
		);
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
