# Enhanced Split View

A clean, performant split view widget for Flutter with smooth animations and an intuitive API.

[![pub package](https://img.shields.io/pub/v/enhanced_split_view.svg)](https://pub.dev/packages/enhanced_split_view)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ What's New in v1.1.0

- 🎯 **Double-Click Reset** - Quickly reset dividers to initial position
- 📏 **Pixel Constraints** - Set min/max sizes in pixels, not just percentages
- 🔽 **Collapsible Panes** - Built-in collapse/expand functionality

[See full changelog](CHANGELOG.md)

## Features

✅ **Simple API** - Easy to use with sensible defaults  
✅ **Smooth Animations** - Built-in animated transitions  
✅ **Flexible** - Horizontal, vertical, and nested layouts  
✅ **Customizable** - Full control over divider styling  
✅ **Performant** - Optimized for smooth 60fps dragging  
✅ **Lightweight** - Only ~400 lines of code, zero dependencies  
✅ **Accessible** - Proper touch targets and visual feedback  
🆕 **Collapsible** - Built-in collapse/expand panes  
🆕 **Smart Constraints** - Pixel-based size limits

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  enhanced_split_view: ^1.1.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:enhanced_split_view/enhanced_split_view.dart';

SplitView(
  direction: SplitDirection.horizontal,
  children: [
    Container(color: Colors.blue),
    Container(color: Colors.green),
  ],
)
```

## Examples

### Basic 2-Pane Split

```dart
SplitView(
  direction: SplitDirection.horizontal,
  children: [
    MyLeftWidget(),
    MyRightWidget(),
  ],
)
```

### 3-Pane Split with Custom Weights

```dart
SplitView(
  direction: SplitDirection.horizontal,
  initialWeights: [0.2, 0.6, 0.2], // 20%, 60%, 20%
  children: [
    Sidebar(),
    MainContent(),
    PropertiesPanel(),
  ],
)
```

### 🆕 Double-Click to Reset (v1.1.0)

```dart
SplitView(
  direction: SplitDirection.horizontal,
  resetOnDoubleClick: true, // Default: true
  initialWeights: [0.3, 0.7],
  children: [
    LeftPane(),
    RightPane(),
  ],
)
// Double-click any divider to reset to initial weights!
```

### 🆕 Pixel-Based Size Constraints (v1.1.0)

```dart
SplitView(
  direction: SplitDirection.horizontal,
  initialWeights: [0.25, 0.5, 0.25],
  sizeConstraints: [
    SizeConstraint(minSize: 200, maxSize: 400), // Sidebar: 200-400px
    SizeConstraint.none,                         // Main: no limits
    SizeConstraint(minSize: 150, maxSize: 300),  // Panel: 150-300px
  ],
  children: [
    Sidebar(),
    MainContent(),
    PropertiesPanel(),
  ],
)
```

### 🆕 Collapsible Panes (v1.1.0)

```dart
SplitView(
  direction: SplitDirection.horizontal,
  children: [
    CollapsiblePane(
      child: Sidebar(),
    ),
    MainContent(),
    CollapsiblePane(
      collapseButtonAlignment: Alignment.topLeft,
      child: PropertiesPanel(),
    ),
  ],
)
```

### Vertical Split

```dart
SplitView(
  direction: SplitDirection.vertical,
  children: [
    TopPane(),
    BottomPane(),
  ],
)
```

### Custom Styling

```dart
SplitView(
  direction: SplitDirection.horizontal,
  dividerStyle: DividerStyle(
    width: 12,
    color: Colors.grey,
    hoverColor: Colors.blue,
    handleSize: 60,
  ),
  children: [
    LeftPane(),
    RightPane(),
  ],
)
```

### Nested Splits (IDE Layout)

```dart
SplitView(
  direction: SplitDirection.vertical,
  initialWeights: [0.75, 0.25],
  children: [
    SplitView(
      direction: SplitDirection.horizontal,
      initialWeights: [0.2, 0.6, 0.2],
      sizeConstraints: [
        SizeConstraint(minSize: 200, maxSize: 400),
        SizeConstraint.none,
        SizeConstraint(minSize: 150, maxSize: 300),
      ],
      children: [
        CollapsiblePane(child: FileExplorer()),
        CodeEditor(),
        CollapsiblePane(
          collapseButtonAlignment: Alignment.topLeft,
          child: PropertiesPanel(),
        ),
      ],
    ),
    ConsolePanel(),
  ],
)
```

### Listen to Size Changes

```dart
SplitView(
  direction: SplitDirection.horizontal,
  onWeightsChanged: (weights) {
    print('New weights: $weights');
    // Save to preferences, update state, etc.
  },
  children: [
    LeftPane(),
    RightPane(),
  ],
)
```

## API Reference

### SplitView

| Property                | Type                          | Default            | Description                                     |
|-------------------------|-------------------------------|--------------------|-------------------------------------------------|
| `direction`             | `SplitDirection`              | `horizontal`       | Layout direction (horizontal or vertical)       |
| `children`              | `List<Widget>`                | required           | Child widgets to display (minimum 2)            |
| `initialWeights`        | `List<double>?`               | equal distribution | Initial size distribution (must sum to 1.0)     |
| `minWeight`             | `double`                      | `0.1`              | Minimum weight for any pane (prevents collapse) |
| `sizeConstraints` 🆕    | `List<SizeConstraint>?`       | `null`             | Pixel-based size constraints per pane           |
| `dividerStyle`          | `DividerStyle`                | default            | Styling for dividers between panes              |
| `onWeightsChanged`      | `ValueChanged<List<double>>?` | `null`             | Called when weights change                      |
| `animated`              | `bool`                        | `true`             | Whether to animate size changes                 |
| `resetOnDoubleClick` 🆕 | `bool`                        | `true`             | Enable double-click to reset dividers           |

### SizeConstraint 🆕 (v1.1.0)

| Property  | Type      | Default | Description            |
|-----------|-----------|---------|------------------------|
| `minSize` | `double?` | `null`  | Minimum size in pixels |
| `maxSize` | `double?` | `null`  | Maximum size in pixels |

**Example:**
```dart
const SizeConstraint(minSize: 200, maxSize: 400)
const SizeConstraint.none // No constraints
```

### CollapsiblePane 🆕 (v1.1.0)

| Property                  | Type                  | Default         | Description                 |
|---------------------------|-----------------------|-----------------|-----------------------------|
| `child`                   | `Widget`              | required        | Content to display          |
| `collapsed`               | `bool`                | `false`         | Initial collapsed state     |
| `onCollapsedChanged`      | `ValueChanged<bool>?` | `null`          | Called when state changes   |
| `collapsedSize`           | `double`              | `0`             | Size when collapsed         |
| `showCollapseButton`      | `bool`                | `true`          | Show collapse/expand button |
| `collapseButtonAlignment` | `Alignment`           | `topRight`      | Button position             |
| `collapseIcon`            | `IconData?`           | `chevron_left`  | Icon for collapse           |
| `expandIcon`              | `IconData?`           | `chevron_right` | Icon for expand             |
| `animationDuration`       | `Duration`            | `300ms`         | Animation duration          |

### DividerStyle

| Property     | Type     | Default | Description                     |
|--------------|----------|---------|---------------------------------|
| `width`      | `double` | `8.0`   | Width of divider (touch target) |
| `color`      | `Color`  | grey    | Base color of divider           |
| `hoverColor` | `Color`  | blue    | Color when hovering             |
| `handleSize` | `double` | `48.0`  | Size of drag handle indicator   |
| `showHandle` | `bool`   | `true`  | Whether to show drag handle     |

## How It Works

### Resizing Behavior

When dragging a divider in a multi-pane layout:
- Only the two **adjacent** panes resize
- Other panes maintain their current size
- Example: In a 3-pane layout (A | B | C), dragging the divider between A and B only affects A and B, while C stays the same size

### 🆕 Double-Click Reset (v1.1.0)

Double-click any divider to instantly reset to `initialWeights`. This is useful for:
- Quick layout reset after experimentation
- Returning to default view
- One-click restore functionality

### 🆕 Pixel Constraints (v1.1.0)

Set min/max sizes in actual pixels instead of percentages:
- **More predictable** on different screen sizes
- **Prevents extreme sizes** (e.g., 1000px sidebar on mobile)
- **Works with weight system** - constraints are enforced during resize

### 🆕 Collapsible Panes (v1.1.0)

Built-in collapse/expand with:
- Automatic button placement
- Smooth animations
- Customizable icons and position
- Perfect for sidebars and tool panels

## Running the Example

To see all examples in action:

```bash
cd example
flutter run
```

The example app includes 9 demos:
1. Basic 2-Pane Split
2. 3-Pane Split with live weight display
3. Vertical Split
4. Nested Splits
5. Custom Styling
6. IDE Layout (complex nested example)
7. 🆕 Double-Click Reset Demo
8. 🆕 Pixel Constraints Demo
9. 🆕 Collapsible Panes Demo

## Performance Tips

- Use `animated: false` for layouts that resize frequently
- For deeply nested splits, consider using `RepaintBoundary` around child widgets
- The package is already optimized for smooth 60fps dragging
- Pixel constraints are checked only during resize (no performance impact)

## Migration Guide

### From v1.0.0 to v1.1.0

No breaking changes! All new features are opt-in:

```dart
// v1.0.0 code works unchanged
SplitView(
  children: [Left(), Right()],
)

// Add v1.1.0 features gradually
SplitView(
  resetOnDoubleClick: true,        // NEW
  sizeConstraints: [...],          // NEW
  children: [
    CollapsiblePane(child: Left()), // NEW
    Right(),
  ],
)
```

## Common Use Cases

- **IDE Layouts**: File explorer, code editor, properties panel, console
- **Dashboards**: Charts, data tables, filters, details panels
- **Email Clients**: Folder list, message list, message preview
- **File Managers**: Directory tree, file list, preview pane
- **Design Tools**: Toolbox, canvas, properties inspector
- **Admin Panels**: Navigation, content, sidebar widgets
- **Data Analysis**: Code editor, output viewer, variable inspector

## Troubleshooting

### Pixel constraints not working

Ensure `sizeConstraints` length matches `children` length:

```dart
SplitView(
  children: [A(), B(), C()],           // 3 children
  sizeConstraints: [                   // 3 constraints
    SizeConstraint(minSize: 200),
    SizeConstraint.none,
    SizeConstraint(maxSize: 300),
  ],
)
```

### Double-click not resetting

Make sure `resetOnDoubleClick: true` (it's the default):

```dart
SplitView(
  resetOnDoubleClick: true,
  initialWeights: [0.3, 0.7], // These are the reset values
  children: [Left(), Right()],
)
```

### Collapsible pane button not visible

Check the `collapseButtonAlignment` and ensure there's space:

```dart
CollapsiblePane(
  collapseButtonAlignment: Alignment.topRight, // Default
  child: Padding(
    padding: EdgeInsets.only(top: 50), // Space for button
    child: YourContent(),
  ),
)
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📫 Email: kapilagarwal96@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/kapil96msd/enhanced_split_view/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/kapil96msd/enhanced_split_view/discussions)
- ⭐ If you find this package helpful, please give it a star on GitHub!

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.

---

Made with ❤️ by Kapil Agarwal