# Enhanced Split View

A clean, performant split view widget for Flutter with smooth animations and an intuitive API.

[![pub package](https://img.shields.io/pub/v/enhanced_split_view.svg)](https://pub.dev/packages/enhanced_split_view)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

✅ **Simple API** - Easy to use with sensible defaults  
✅ **Smooth Animations** - Built-in animated transitions  
✅ **Flexible** - Horizontal, vertical, and nested layouts  
✅ **Customizable** - Full control over divider styling  
✅ **Performant** - Optimized for smooth 60fps dragging  
✅ **Lightweight** - Only ~300 lines of code, zero dependencies  
✅ **Accessible** - Proper touch targets and visual feedback

## Screenshots

> **Note**: Screenshots will be added after initial release. For now, run the example app to see all features in action.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  enhanced_split_view: ^1.0.0
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
      children: [
        FileExplorer(),
        CodeEditor(),
        PropertiesPanel(),
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

### Disable Animation

```dart
SplitView(
  direction: SplitDirection.horizontal,
  animated: false, // Instant resizing
  children: [
    LeftPane(),
    RightPane(),
  ],
)
```

### Set Minimum Pane Size

```dart
SplitView(
  direction: SplitDirection.horizontal,
  minWeight: 0.15, // Minimum 15% for any pane
  children: [
    LeftPane(),
    RightPane(),
  ],
)
```

## API Reference

### SplitView

| Property           | Type                          | Default            | Description                                     |
|--------------------|-------------------------------|--------------------|-------------------------------------------------|
| `direction`        | `SplitDirection`              | `horizontal`       | Layout direction (horizontal or vertical)       |
| `children`         | `List<Widget>`                | required           | Child widgets to display (minimum 2)            |
| `initialWeights`   | `List<double>?`               | equal distribution | Initial size distribution (must sum to 1.0)     |
| `minWeight`        | `double`                      | `0.1`              | Minimum weight for any pane (prevents collapse) |
| `dividerStyle`     | `DividerStyle`                | default            | Styling for dividers between panes              |
| `onWeightsChanged` | `ValueChanged<List<double>>?` | `null`             | Called when weights change                      |
| `animated`         | `bool`                        | `true`             | Whether to animate size changes                 |

### DividerStyle

| Property     | Type     | Default | Description                     |
|--------------|----------|---------|---------------------------------|
| `width`      | `double` | `8.0`   | Width of divider (touch target) |
| `color`      | `Color`  | grey    | Base color of divider           |
| `hoverColor` | `Color`  | blue    | Color when hovering             |
| `handleSize` | `double` | `48.0`  | Size of drag handle indicator   |
| `showHandle` | `bool`   | `true`  | Whether to show drag handle     |

## How Resizing Works

When dragging a divider in a multi-pane layout:
- Only the two **adjacent** panes resize (the ones on either side of the divider)
- Other panes maintain their current size
- Example: In a 3-pane layout (A | B | C):
    - Dragging divider 1 (between A and B) resizes A and B only
    - Dragging divider 2 (between B and C) resizes B and C only
    - Pane C stays fixed when dragging divider 1
    - Pane A stays fixed when dragging divider 2

This behavior provides intuitive and predictable resizing, especially in complex layouts with many panes.

## Running the Example

To see all examples in action:

```bash
cd example
flutter run
```

The example app includes:
1. Basic 2-Pane Split
2. 3-Pane Split with live weight display
3. Vertical Split
4. Nested Splits
5. Custom Styling
6. IDE Layout (complex nested example)

## Performance Tips

- Use `animated: false` for layouts that resize frequently
- For deeply nested splits, consider using `RepaintBoundary` around child widgets to prevent unnecessary repaints
- The package is already optimized for smooth 60fps dragging
- Weights are normalized automatically, but providing correct initial weights avoids unnecessary calculations

## Accessibility

- Proper mouse cursors for resize affordance (`resizeColumn`, `resizeRow`)
- Large touch targets (default 8px divider width, 48px handle)
- Visual feedback on hover and drag
- Minimum size constraints to prevent inaccessible layouts
- Works with keyboard navigation when focused (system-default behavior)

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure:
- All tests pass (`flutter test`)
- Code follows the existing style (`flutter analyze`)
- New features include tests and documentation
- Update CHANGELOG.md

## Troubleshooting

### Weights don't sum to 1.0

The package automatically normalizes weights, but it's best practice to ensure they sum to 1.0:

```dart
// ❌ Avoid
initialWeights: [0.3, 0.4, 0.2] // sums to 0.9

// ✅ Correct
initialWeights: [0.3, 0.4, 0.3] // sums to 1.0
```

### Panes are too small

Increase the `minWeight` property:

```dart
SplitView(
  minWeight: 0.2, // Minimum 20%
  // ...
)
```

### Animation is jerky

Try disabling animation for better performance:

```dart
SplitView(
  animated: false,
  // ...
)
```

### Divider is hard to grab

Increase the divider width for larger touch targets:

```dart
SplitView(
  dividerStyle: DividerStyle(
    width: 16, // Larger touch target
  ),
  // ...
)
```

## Common Use Cases

- **IDE Layouts**: File explorer, code editor, properties panel, console
- **Dashboards**: Charts, data tables, filters, details panels
- **Email Clients**: Folder list, message list, message preview
- **File Managers**: Directory tree, file list, preview pane
- **Design Tools**: Toolbox, canvas, properties inspector
- **Admin Panels**: Navigation, content, sidebar widgets

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📧 Email: kapilagarwal96@gmail.com
- 🐛 Issues: [GitHub Issues](https://github.com/kapil96msd/enhanced_split_view/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/kapil96msd/enhanced_split_view/discussions)
- ⭐ If you find this package helpful, please give it a star on GitHub!

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.

---

Made with ❤️ by Kapil Agarwal