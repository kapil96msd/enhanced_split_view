# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-10-15

### Added
- **Double-Click Reset**: Double-click any divider to reset to initial weights
    - New `resetOnDoubleClick` parameter (default: `true`)
    - Perfect for quickly restoring layout after experimentation
- **Pixel-Based Size Constraints**: Set min/max sizes in pixels, not just percentages
    - New `SizeConstraint` class with `minSize` and `maxSize` properties
    - New `sizeConstraints` parameter on `SplitView`
    - More predictable layouts across different screen sizes
- **Collapsible Panes**: Built-in collapse/expand functionality
    - New `CollapsiblePane` widget
    - Configurable collapse button position and icons
    - Smooth collapse/expand animations
    - Perfect for sidebars and tool panels
- Three new example demos showcasing v1.1.0 features
- Additional tests for new features (30+ total tests)

### Changed
- Improved internal state management for better performance
- Enhanced documentation with v1.1.0 feature examples

### Fixed
- Better handling of edge cases with size constraints
- Improved animation consistency

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

[1.1.0]: https://github.com/kapil96msd/enhanced_split_view/releases/tag/v1.1.0
[1.0.0]: https://github.com/kapil96msd/enhanced_split_view/releases/tag/v1.0.0