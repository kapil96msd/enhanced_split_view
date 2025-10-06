// ============================================================================
// FILE: lib/src/split_view.dart
// ============================================================================
import 'package:flutter/material.dart';
import 'models.dart';

/// A resizable split view widget that divides available space between children.
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

  /// Styling for dividers between panes
  final DividerStyle dividerStyle;

  /// Called when weights change due to user interaction
  final ValueChanged<List<double>>? onWeightsChanged;

  /// Whether to animate size changes
  final bool animated;

  const SplitView({
    super.key,
    this.direction = SplitDirection.horizontal,
    required this.children,
    this.initialWeights,
    this.minWeight = 0.1,
    this.dividerStyle = const DividerStyle(),
    this.onWeightsChanged,
    this.animated = true,
  }) : assert(children.length >= 2, 'Need at least 2 children');

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  late List<double> _weights;

  @override
  void initState() {
    super.initState();
    _initializeWeights();
  }

  void _initializeWeights() {
    if (widget.initialWeights != null &&
        widget.initialWeights!.length == widget.children.length) {
      _weights = List.from(widget.initialWeights!);
    } else {
      final equal = 1.0 / widget.children.length;
      _weights = List.filled(widget.children.length, equal);
    }
    _normalizeWeights();
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

  void _updateWeights(int dividerIndex, double delta, double totalSize) {
    final leftIndex = dividerIndex;
    final rightIndex = dividerIndex + 1;

    final deltaWeight = delta / totalSize;
    final newLeftWeight = (_weights[leftIndex] + deltaWeight).clamp(
      widget.minWeight,
      1.0 - widget.minWeight,
    );
    final newRightWeight = (_weights[rightIndex] - deltaWeight).clamp(
      widget.minWeight,
      1.0 - widget.minWeight,
    );

    if (newLeftWeight >= widget.minWeight &&
        newRightWeight >= widget.minWeight) {
      setState(() {
        _weights[leftIndex] = newLeftWeight;
        _weights[rightIndex] = newRightWeight;
        _normalizeWeights();
      });
      widget.onWeightsChanged?.call(_weights);
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
          children: _buildChildren(contentSize, totalSize, isHorizontal),
        );
      },
    );
  }

  List<Widget> _buildChildren(
    double contentSize,
    double totalSize,
    bool isHorizontal,
  ) {
    final children = <Widget>[];

    for (int i = 0; i < widget.children.length; i++) {
      final size = contentSize * _weights[i];

      children.add(
        _AnimatedPane(
          size: size,
          isHorizontal: isHorizontal,
          animate: widget.animated,
          child: widget.children[i],
        ),
      );

      if (i < widget.children.length - 1) {
        children.add(
          _Divider(
            index: i,
            isHorizontal: isHorizontal,
            style: widget.dividerStyle,
            onDrag: (delta) => _updateWeights(i, delta, totalSize),
          ),
        );
      }
    }

    return children;
  }
}

class _AnimatedPane extends StatelessWidget {
  final double size;
  final bool isHorizontal;
  final bool animate;
  final Widget child;

  const _AnimatedPane({
    required this.size,
    required this.isHorizontal,
    required this.animate,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final sizedChild = SizedBox(
      width: isHorizontal ? size : null,
      height: isHorizontal ? null : size,
      child: child,
    );

    if (!animate) return sizedChild;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: size, end: size),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      builder: (context, animatedSize, _) => SizedBox(
        width: isHorizontal ? animatedSize : null,
        height: isHorizontal ? null : animatedSize,
        child: child,
      ),
    );
  }
}

class _Divider extends StatefulWidget {
  final int index;
  final bool isHorizontal;
  final DividerStyle style;
  final ValueChanged<double> onDrag;

  const _Divider({
    required this.index,
    required this.isHorizontal,
    required this.style,
    required this.onDrag,
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
