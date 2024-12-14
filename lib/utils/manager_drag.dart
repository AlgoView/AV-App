import 'package:flutter/material.dart';

class ManagerDrag {
  bool isHovered = false;
  bool isDragging = false;
  double dragStartY = 0;

  void onDragStart(double startY) {
    isDragging = true;
    dragStartY = startY;
  }

  double onDragUpdate(double currentY, double previousHeight, double min, double max, Function(bool) togglePanel) {
    double delta = dragStartY - currentY;
    dragStartY = currentY;
    double newHeight = previousHeight + delta;

    if (newHeight < min) {
      togglePanel(false);
      return min;
    } else if (newHeight >= min) {
      togglePanel(true);
      return newHeight.clamp(min, max);
    }

    return previousHeight;
  }

  void onDragEnd() {
    isDragging = false;
  }

  void onHoverEnter() {
    isHovered = true;
  }

  void onHoverExit() {
    isHovered = false;
  }
}
