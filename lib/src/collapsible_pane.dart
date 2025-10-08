// ============================================================================
// FILE: lib/src/collapsible_pane.dart (FINAL FIXED v1.1.0)
// ============================================================================
import 'package:flutter/material.dart';

/// A pane that can be collapsed/expanded within a SplitView
///
/// This widget should be used inside a SplitView. The parent must manage
/// the collapse state and update SplitView weights accordingly.
///
/// Example:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   bool _collapsed = false;
///
///   Widget build(BuildContext context) {
///     return SplitView(
///       key: ValueKey(_collapsed),
///       initialWeights: _collapsed ? [0.05, 0.95] : [0.3, 0.7],
///       children: [
///         CollapsiblePane(
///           collapsed: _collapsed,
///           onCollapsedChanged: (c) => setState(() => _collapsed = c),
///           child: Sidebar(),
///         ),
///         MainContent(),
///       ],
///     );
///   }
/// }
/// ```
class CollapsiblePane extends StatefulWidget {
  /// The child widget to display when expanded
  final Widget child;

  /// Whether the pane is currently collapsed
  final bool collapsed;

  /// Called when user clicks the collapse/expand button
  final ValueChanged<bool>? onCollapsedChanged;

  /// Size when collapsed in pixels (default: 48px for button)
  final double collapsedSize;

  /// Show collapse/expand button
  final bool showCollapseButton;

  /// Position of the collapse button
  final Alignment collapseButtonAlignment;

  /// Icon for collapse button (pointing away from content)
  final IconData? collapseIcon;

  /// Icon for expand button (pointing toward content)
  final IconData? expandIcon;

  /// Duration of collapse/expand animation
  final Duration animationDuration;

  /// Background color when collapsed
  final Color? collapsedColor;

  const CollapsiblePane({
    super.key,
    required this.child,
    this.collapsed = false,
    this.onCollapsedChanged,
    this.collapsedSize = 48,
    this.showCollapseButton = true,
    this.collapseButtonAlignment = Alignment.topRight,
    this.collapseIcon,
    this.expandIcon,
    this.animationDuration = const Duration(milliseconds: 300),
    this.collapsedColor,
  });

  @override
  State<CollapsiblePane> createState() => _CollapsiblePaneState();
}

class _CollapsiblePaneState extends State<CollapsiblePane> {
  late bool _collapsed;

  @override
  void initState() {
    super.initState();
    _collapsed = widget.collapsed;
  }

  @override
  void didUpdateWidget(CollapsiblePane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.collapsed != oldWidget.collapsed) {
      _collapsed = widget.collapsed;
    }
  }

  void _toggleCollapsed() {
    setState(() {
      _collapsed = !_collapsed;
    });
    widget.onCollapsedChanged?.call(_collapsed);
  }

  IconData _getIconData() {
    // Determine which direction the icon should point based on alignment
    final isLeft = widget.collapseButtonAlignment.x < 0;

    if (_collapsed) {
      // When collapsed, show expand icon
      if (widget.expandIcon != null) return widget.expandIcon!;
      return isLeft ? Icons.chevron_right : Icons.chevron_left;
    } else {
      // When expanded, show collapse icon
      if (widget.collapseIcon != null) return widget.collapseIcon!;
      return isLeft ? Icons.chevron_left : Icons.chevron_right;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_collapsed) {
      // When collapsed, show only the button with minimal content
      return Container(
        color: widget.collapsedColor ?? Colors.grey.shade200,
        child: Center(
          child: IconButton(
            icon: Icon(_getIconData()),
            onPressed: _toggleCollapsed,
            tooltip: 'Expand',
          ),
        ),
      );
    }

    // When expanded, show content with button overlay
    return Stack(
      children: [
        // Main content
        widget.child,

        // Collapse button overlay
        if (widget.showCollapseButton)
          Align(
            alignment: widget.collapseButtonAlignment,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(4),
                elevation: 2,
                child: IconButton(
                  icon: Icon(_getIconData()),
                  onPressed: _toggleCollapsed,
                  tooltip: 'Collapse',
                ),
              ),
            ),
          ),
      ],
    );
  }
}
