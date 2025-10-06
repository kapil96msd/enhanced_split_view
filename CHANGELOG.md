# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-06

### Added
- Initial release of Enhanced Split View
- Horizontal and vertical split views
- Resizable panes with drag-to-resize functionality
- Smooth animations using AnimatedSize widget
- Customizable divider styling with DividerStyle class
- Support for 2+ panes in a single split view
- Nested split layouts for complex interfaces
- Weight distribution system for flexible sizing
- Minimum weight constraints to prevent pane collapse
- `onWeightsChanged` callback for tracking resize events
- Comprehensive example app with 6 interactive demos
- Full test coverage with 20+ test cases
- Complete API documentation with dartdoc comments
- MIT License

### Features
- Clean, intuitive API with sensible defaults
- Zero external dependencies
- Lightweight implementation (~300 lines)
- 60fps smooth dragging performance
- Proper touch targets for mobile accessibility
- Hover effects for desktop interactions
- Animated transitions between sizes
- Adjacent-pane-only resizing (intelligent behavior)
- Automatic weight normalization
- Debug mode warnings for configuration issues

### Technical
- Immutable `DividerStyle` class with proper equality operators
- Proper animation state management with AnimatedSize
- Comprehensive edge case handling
- Widget keys for performance optimization
- Mouse cursor changes for resize affordance
- Support for horizontal and vertical layouts
- Flexible layout using Flex widget

### Documentation
- Complete README with usage examples
- API reference table
- Troubleshooting guide
- Common use cases section
- Performance tips
- Accessibility features documented

### Example App
- Navigation rail for easy demo switching
- Basic 2-pane split demonstration
- 3-pane split with live weight display
- Vertical split example
- Nested splits example
- Custom styling demonstration
- IDE layout (complex nested) example

[1.0.0]: https://github.com/kapil96msd/enhanced_split_view/releases/tag/v1.0.0

---