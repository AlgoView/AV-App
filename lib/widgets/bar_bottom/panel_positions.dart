import 'package:flutter/material.dart';
import '../../theme/colors.dart';

// Hardcoded variables
const double minHeight = 100;
const double handleHeight = 4;
const double panelPadding = 16;

class PanelPositions extends StatefulWidget {
	final double initialHeight;
	final double maxHeight;
	final Function(double height) onHeightChanged;

	static const double minHeight = 100;
	static const double handleHeight = 4;

	const PanelPositions({
		super.key,
		required this.initialHeight,
		required this.maxHeight,
		required this.onHeightChanged,
	});

	@override
	State<PanelPositions> createState() => _PanelPositionsState();
}

class _PanelPositionsState extends State<PanelPositions> {
	late double height;
	bool isDragging = false;

	@override
	void initState() {
		super.initState();
		height = widget.initialHeight;
	}

	void _startDragging(DragStartDetails details) {
		setState(() => isDragging = true);
	}

	void _updateDragging(DragUpdateDetails details) {
		setState(() {
			height -= details.delta.dy;
			height = height.clamp(PanelPositions.minHeight, widget.maxHeight);
			widget.onHeightChanged(height);
		});
	}

	void _endDragging(DragEndDetails details) {
		setState(() => isDragging = false);
	}

	@override
	Widget build(BuildContext context) {
		return Stack(
			children: [
				Positioned(
					bottom: 0,
					left: 0,
					right: 0,
					height: height,
					child: Container(
						decoration: const BoxDecoration(
							color: AppTheme.panelColor,
							border: Border(
								top: BorderSide(color: AppTheme.panelBorderColor, width: 1),
							),
						),
						padding: const EdgeInsets.all(panelPadding),
						child: const Center(
							child: Text(
								'Positions Panel',
								style: TextStyle(color: AppTheme.activeIconColor),
							),
						),
					),
				),
				Positioned(
					bottom: height,
					left: 0,
					right: 0,
					height: PanelPositions.handleHeight,
					child: GestureDetector(
						onPanStart: _startDragging,
						onPanUpdate: _updateDragging,
						onPanEnd: _endDragging,
						child: MouseRegion(
							cursor: SystemMouseCursors.resizeRow,
							child: Container(
								color: isDragging
										? AppTheme.highlightColor
										: Colors.transparent,
							),
						),
					),
				),
			],
		);
	}
}
