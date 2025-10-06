# Enhanced Split View - Example App

This example app demonstrates all features of the Enhanced Split View package.

## Running the Example

```bash
flutter run
```

Or from the root directory:

```bash
cd example
flutter run
```

## What's Included

The example app showcases 6 different use cases:

1. **Basic 2-Pane** - Simple horizontal split with two colored panes
2. **3-Pane Split** - Three panes with live weight display showing resize behavior
3. **Vertical Split** - Top/bottom layout demonstration
4. **Nested Splits** - Sidebar with nested vertical split (main/footer)
5. **Custom Styling** - Purple themed dividers with custom colors and sizes
6. **IDE Layout** - Complex nested split mimicking an IDE interface (file explorer, editor, properties, console)

## Key Features Demonstrated

- Horizontal and vertical layouts
- Multi-pane splits (2+ panes)
- Custom initial weights
- Live weight tracking with `onWeightsChanged`
- Custom divider styling
- Nested split views
- Adjacent-pane resizing behavior

## Code Organization

The example is organized in a single file (`lib/main.dart`) with:
- Main app with navigation rail
- Individual example widgets for each demo
- Reusable helper methods for building panes

## Building for Release

```bash
# Android
flutter build apk

# iOS (requires macOS)
flutter build ios

# Web
flutter build web

# Desktop (Windows)
flutter build windows

# Desktop (macOS)
flutter build macos

# Desktop (Linux)
flutter build linux
```

## Learning Resources

After running the examples, check out the main package documentation for detailed API reference and usage patterns.

## Feedback

If you have ideas for additional examples, please open an issue on the GitHub repository.