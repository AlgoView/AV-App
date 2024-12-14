class ManagerDrag {
	bool isDragging = false;
	double dragStartY = 0;
	bool isHoverHighlight = false;
	static const double collapseThreshold = 60.0;
	static const double minHeight = 200.0;

	void onDragStart(double startY) {
		isDragging = true;
		dragStartY = startY;
	}

	void onDragEnd(double currentHeight, Function updateState) {
		isDragging = false;

		// Finalize height
		if (currentHeight < collapseThreshold) {
			updateState(0, false); // Collapse
		} else if (currentHeight < minHeight) {
			updateState(minHeight, true); // Set to minimum height
		}
	}

	double handleDrag(double currentY, double currentHeight, double maxHeight) {
		double dragDelta = dragStartY - currentY;
		dragStartY = currentY;

		if (currentHeight == 0 && dragDelta < -collapseThreshold) {
			return minHeight; // Expand from collapsed
		}

		if (currentHeight > 0) {
			double newHeight = currentHeight + dragDelta;
			return newHeight.clamp(0, maxHeight); // Clamp height
		}

		return currentHeight;
	}

	void manageHover(bool isEntering, Function updateState) {
		if (isEntering) {
			Future.delayed(const Duration(milliseconds: 200), () {
				if (!isDragging) {
					updateState(true); // Highlight on hover
				}
			});
		} else {
			updateState(false); // Remove highlight
		}
	}
}
