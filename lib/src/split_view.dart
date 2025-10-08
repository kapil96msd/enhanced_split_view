// ============================================================================
// FILE: lib/src/split_view.dart (v1.1.0 - FIXED)
// ============================================================================
import 'package:flutter/material.dart';
import 'models.dart';

/// A resizable split view widget that divides available space between children.
///
/// Version 1.1.0 adds:
/// - Double-click to reset dividers
/// - Pixel-based size constraints
/// - Collapsible panes
///
/// Example:
/// ```dart
/// SplitView(
///   direction: SplitDirection.horizontal,
///   children: [
///     Container(color: Colors.blue),
///     Container(color: Colors.green),
///   ],
/// )
/// ```
class SplitView extends StatefulWidget {
  /// Direction of the split (horizontal or vertical)
  final SplitDirection direction;

  /// Child widgets to display in each pane
  final List<Widget> children;

  /// Initial weight distribution for each pane (must sum to 1.0)
  final List<double>? initialWeights;

  /// Minimum weight any pane can have (prevents panes from becoming too small)
  final double minWeight;

  /// Size constraints for each pane in pixels (optional)
  ///
  /// If provided, must have same length as children.
  /// Use SizeConstraint.none for panes without constraints.
  final List<SizeConstraint>? sizeConstraints;

  /// Styling for dividers between panes
  final DividerStyle dividerStyle;

  /// Called when weights change due to user interaction
  final ValueChanged<List<double>>? onWeightsChanged;

  /// Whether to animate size changes
  final bool animated;

  /// Enable double-click on divider to reset to initial weights
  final bool resetOnDoubleClick;

  const SplitView({
    super.key,
    this.direction = SplitDirection.horizontal,
    required this.children,
    this.initialWeights,
    this.minWeight = 0.1,
    this.sizeConstraints,
    this.dividerStyle = const DividerStyle(),
    this.onWeightsChanged,
    this.animated = true,
    this.resetOnDoubleClick = true,
  }) : assert(
         children.length >= 2,
         'SplitView requires at least 2 children, but got ${children.length}',
       ),
       assert(
         sizeConstraints == null || sizeConstraints.length == children.length,
         'sizeConstraints length must match children length',
       );

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  late List<double> _weights;
  late List<double> _initialWeights;

  @override
  void initState() {
    super.initState();
    _initializeWeights();
  }

  void _initializeWeights() {
    if (widget.initialWeights != null &&
        widget.initialWeights!.length == widget.children.length) {
      _weights = List.from(widget.initialWeights!);
      _normalizeWeights();

      // Validate sum in debug mode
      if (widget.initialWeights != null) {
        final sum = widget.initialWeights!.fold<double>(0.0, (a, b) => a + b);
        if ((sum - 1.0).abs() > 0.01) {
          debugPrint(
            'Warning: initialWeights should sum to 1.0, but sum to $sum. '
            'Weights have been normalized.',
          );
        }
      }
    } else {
      if (widget.initialWeights != null) {
        debugPrint(
          'Warning: initialWeights length (${widget.initialWeights!.length}) '
          'does not match children length (${widget.children.length}). '
          'Using equal distribution instead.',
        );
      }
      final equal = 1.0 / widget.children.length;
      _weights = List.filled(widget.children.length, equal);
    }

    // Store initial weights for reset functionality
    _initialWeights = List.from(_weights);
  }

  @override
  void didUpdateWidget(SplitView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      _initializeWeights();
    }
  }

  void _normalizeWeights() {
    final sum = _weights.fold<double>(0.0, (a, b) => a + b);
    if (sum > 0) {
      for (int i = 0; i < _weights.length; i++) {
        _weights[i] /= sum;
      }
    }
  }

  /// Reset weights to initial values
  void _resetWeights(int dividerIndex) {
    if (!widget.resetOnDoubleClick) return;

    setState(() {
      _weights = List.from(_initialWeights);
    });
    widget.onWeightsChanged?.call(List.unmodifiable(_weights));
  }

  void _updateWeights(int dividerIndex, double delta, double contentSize) {
    final leftIndex = dividerIndex;
    final rightIndex = dividerIndex + 1;

    // FIXED: Use contentSize (which excludes dividers) for all calculations
    final deltaWeight = delta / contentSize;

    // Calculate new weights for the two adjacent panes
    var newLeftWeight = _weights[leftIndex] + deltaWeight;
    var newRightWeight = _weights[rightIndex] - deltaWeight;

    // Apply minimum weight constraints
    if (newLeftWeight < widget.minWeight) {
      newLeftWeight = widget.minWeight;
      newRightWeight =
          _weights[leftIndex] + _weights[rightIndex] - newLeftWeight;
    }
    if (newRightWeight < widget.minWeight) {
      newRightWeight = widget.minWeight;
      newLeftWeight =
          _weights[leftIndex] + _weights[rightIndex] - newRightWeight;
    }

    // FIXED: Apply pixel-based size constraints using contentSize
    if (widget.sizeConstraints != null) {
      final leftConstraint = widget.sizeConstraints![leftIndex];
      final rightConstraint = widget.sizeConstraints![rightIndex];

      // Calculate actual pixel sizes based on contentSize (not totalSize)
      final leftSize = contentSize * newLeftWeight;
      final rightSize = contentSize * newRightWeight;

      // Check left pane min/max
      if (leftConstraint.minSize != null &&
          leftSize < leftConstraint.minSize!) {
        newLeftWeight = leftConstraint.minSize! / contentSize;
        newRightWeight =
            _weights[leftIndex] + _weights[rightIndex] - newLeftWeight;
      }
      if (leftConstraint.maxSize != null &&
          leftSize > leftConstraint.maxSize!) {
        newLeftWeight = leftConstraint.maxSize! / contentSize;
        newRightWeight =
            _weights[leftIndex] + _weights[rightIndex] - newLeftWeight;
      }

      // Check right pane min/max
      if (rightConstraint.minSize != null &&
          rightSize < rightConstraint.minSize!) {
        newRightWeight = rightConstraint.minSize! / contentSize;
        newLeftWeight =
            _weights[leftIndex] + _weights[rightIndex] - newRightWeight;
      }
      if (rightConstraint.maxSize != null &&
          rightSize > rightConstraint.maxSize!) {
        newRightWeight = rightConstraint.maxSize! / contentSize;
        newLeftWeight =
            _weights[leftIndex] + _weights[rightIndex] - newRightWeight;
      }
    }

    // Only update if both constraints are satisfied
    if (newLeftWeight >= widget.minWeight &&
        newRightWeight >= widget.minWeight) {
      setState(() {
        _weights[leftIndex] = newLeftWeight;
        _weights[rightIndex] = newRightWeight;
      });
      widget.onWeightsChanged?.call(List.unmodifiable(_weights));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isHorizontal = widget.direction == SplitDirection.horizontal;
        final totalSize = isHorizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        final dividerCount = widget.children.length - 1;
        final contentSize =
            totalSize - (widget.dividerStyle.width * dividerCount);

        if (contentSize <= 0) {
          return const SizedBox();
        }

        return Flex(
          direction: isHorizontal ? Axis.horizontal : Axis.vertical,
          children: _buildChildren(contentSize, isHorizontal),
        );
      },
    );
  }

  List<Widget> _buildChildren(double contentSize, bool isHorizontal) {
    final children = <Widget>[];

    for (int i = 0; i < widget.children.length; i++) {
      final size = contentSize * _weights[i];

      children.add(
        _AnimatedPane(
          key: ValueKey('pane_$i'),
          size: size,
          isHorizontal: isHorizontal,
          animate: widget.animated,
          child: widget.children[i],
        ),
      );

      if (i < widget.children.length - 1) {
        children.add(
          _Divider(
            key: ValueKey('divider_$i'),
            index: i,
            isHorizontal: isHorizontal,
            style: widget.dividerStyle,
            onDrag: (delta) => _updateWeights(i, delta, contentSize),
            onReset: widget.resetOnDoubleClick ? () => _resetWeights(i) : null,
          ),
        );
      }
    }

    return children;
  }
}

/// Animated pane widget with proper animation handling
class _AnimatedPane extends StatefulWidget {
  final double size;
  final bool isHorizontal;
  final bool animate;
  final Widget child;

  const _AnimatedPane({
    super.key,
    required this.size,
    required this.isHorizontal,
    required this.animate,
    required this.child,
  });

  @override
  State<_AnimatedPane> createState() => _AnimatedPaneState();
}

class _AnimatedPaneState extends State<_AnimatedPane> {
  double? _previousSize;

  @override
  void initState() {
    super.initState();
    _previousSize = widget.size;
  }

  @override
  void didUpdateWidget(_AnimatedPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.size != widget.size) {
      _previousSize = oldWidget.size;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return SizedBox(
        width: widget.isHorizontal ? widget.size : null,
        height: widget.isHorizontal ? null : widget.size,
        child: widget.child,
      );
    }

    return TweenAnimationBuilder<double>(
      key: ValueKey(widget.size),
      tween: Tween(begin: _previousSize ?? widget.size, end: widget.size),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      onEnd: () {
        if (mounted) {
          setState(() => _previousSize = widget.size);
        }
      },
      builder: (context, animatedSize, _) => SizedBox(
        width: widget.isHorizontal ? animatedSize : null,
        height: widget.isHorizontal ? null : animatedSize,
        child: widget.child,
      ),
    );
  }
}

/// Divider widget with hover, drag, and double-click support
class _Divider extends StatefulWidget {
  final int index;
  final bool isHorizontal;
  final DividerStyle style;
  final ValueChanged<double> onDrag;
  final VoidCallback? onReset;

  const _Divider({
    super.key,
    required this.index,
    required this.isHorizontal,
    required this.style,
    required this.onDrag,
    this.onReset,
  });

  @override
  State<_Divider> createState() => _DividerState();
}

class _DividerState extends State<_Divider> {
  bool _isHovering = false;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final isActive = _isHovering || _isDragging;
    final color = isActive ? widget.style.hoverColor : widget.style.color;

    return MouseRegion(
      cursor: widget.isHorizontal
          ? SystemMouseCursors.resizeColumn
          : SystemMouseCursors.resizeRow,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onPanUpdate: (details) {
          final delta = widget.isHorizontal
              ? details.delta.dx
              : details.delta.dy;
          widget.onDrag(delta);
        },
        onPanStart: (_) => setState(() => _isDragging = true),
        onPanEnd: (_) => setState(() => _isDragging = false),
        onPanCancel: () => setState(() => _isDragging = false),
        onDoubleTap: widget.onReset,
        child: Container(
          width: widget.isHorizontal ? widget.style.width : null,
          height: widget.isHorizontal ? null : widget.style.width,
          color: color.withValues(alpha: 0.3),
          child: widget.style.showHandle
              ? Center(
                  child: AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 150),
                    child: Container(
                      width: widget.isHorizontal ? 4 : widget.style.handleSize,
                      height: widget.isHorizontal ? widget.style.handleSize : 4,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
