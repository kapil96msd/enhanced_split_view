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

Quick Start
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

Examples

Basic 2-Pane Split
```dart
SplitView(
  direction: SplitDirection.horizontal,
  children: [
    MyLeftWidget(),
    MyRightWidget(),
  ],
)
```

3-Pane Split with Custom Weights
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

Vertical Split
```dart
SplitView(
  direction: SplitDirection.vertical,
  children: [
    TopPane(),
    BottomPane(),
  ],
)
```

Custom Styling
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

Nested Splits (IDE Layout)
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

Listen to Size Changes
```dart
SplitView(
  direction: SplitDirection.horizontal,
  onWeightsChanged: (weights) {
    print('New weights: $weights');
  },
  children: [
    LeftPane(),
    RightPane(),
  ],
)
```

Running the Example
```bash
cd example
flutter run
```

## Contributing
Contributions are welcome! 
Please read our contributing guide and submit pull requests to our repository.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Support
If you find this package helpful, please give it a ⭐ on GitHub!
For issues and feature requests, please use the issue tracker.

