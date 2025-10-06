// ============================================================================
// FILE: lib/src/models.dart
// ============================================================================
import 'package:flutter/material.dart';

/// Direction of split
enum SplitDirection {
  /// Side by side layout
  horizontal,

  /// Top to bottom layout
  vertical,
}

/// Styling for the divider between panes
// @immutable
class DividerStyle {
  /// Width of the divider area (touch target)
  final double width;

  /// Base color of the divider
  final Color color;

  /// Color when hovering over divider
  final Color hoverColor;

  /// Size of the drag handle indicator
  final double handleSize;

  /// Whether to show the drag handle
  final bool showHandle;

  const DividerStyle({
    this.width = 8.0,
    this.color = const Color(0xFFE0E0E0),
    this.hoverColor = const Color(0xFF2196F3),
    this.handleSize = 48.0,
    this.showHandle = true,
  });

  DividerStyle copyWith({
    double? width,
    Color? color,
    Color? hoverColor,
    double? handleSize,
    bool? showHandle,
  }) {
    return DividerStyle(
      width: width ?? this.width,
      color: color ?? this.color,
      hoverColor: hoverColor ?? this.hoverColor,
      handleSize: handleSize ?? this.handleSize,
      showHandle: showHandle ?? this.showHandle,
    );
  }
}
