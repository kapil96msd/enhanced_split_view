# Contributing to Enhanced Split View

First off, thank you for considering contributing to Enhanced Split View! It's people like you that make this package better for everyone.

## Code of Conduct

This project and everyone participating in it is governed by common sense and mutual respect. Be kind, be professional, and help create a welcoming environment for all contributors.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** - Include code snippets, screenshots, or GIFs
- **Describe the behavior you observed** and what you expected to see
- **Include Flutter and Dart versions** (`flutter --version`)
- **Include device/platform information**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful** to most users
- **Provide code examples** if applicable

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the coding style** used throughout the project
3. **Write or update tests** for your changes
4. **Ensure all tests pass** (`flutter test`)
5. **Update documentation** (README, inline docs, etc.)
6. **Write clear commit messages**
7. **Submit the pull request**

## Development Setup

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK (compatible with Flutter)
- Git

### Getting Started

```bash
# Clone your fork
git clone https://github.com/your-username/enhanced_split_view.git
cd enhanced_split_view

# Get dependencies
flutter pub get

# Run tests
flutter test

# Run the example
cd example
flutter run
```

## Coding Guidelines

### Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use the analyzer rules defined in `analysis_options.yaml`
- Run `flutter analyze` before committing

### Code Quality

- **Keep it simple** - Prefer clarity over cleverness
- **Write tests** - Aim for high test coverage
- **Document public APIs** - Use dartdoc comments
- **Avoid breaking changes** - Or clearly document them

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally

Example:
```
Add keyboard navigation support

- Implement arrow key handlers
- Add focus management
- Update documentation

Closes #42
```

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/enhanced_split_view_test.dart
```

### Writing Tests

- Write tests for all new features
- Write tests for bug fixes
- Use descriptive test names
- Group related tests together
- Test edge cases

Example:

group('SplitView', () {
  testWidgets('renders with custom weights', (tester) async {
    // Test implementation
  });
  
  testWidgets('respects minWeight constraint', (tester) async {
    // Test implementation
  });
});


## Documentation

### Inline Documentation

Use dartdoc comments for all public APIs:

```dart
/// A resizable split view widget.
///
/// Example:
/// ```dart
/// SplitView(
///   direction: SplitDirection.horizontal,
///   children: [widget1, widget2],
/// )
/// ```
class SplitView extends StatefulWidget {
  /// Direction of the split.
  final SplitDirection direction;
  
  // ...
}
```

### README Updates

If your change affects usage:
- Update code examples
- Add new examples if introducing features
- Update the API reference table
- Add troubleshooting tips if relevant

## Release Process

(For maintainers)

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Run tests: `flutter test`
4. Commit changes: `git commit -am "Release v1.x.x"`
5. Tag release: `git tag v1.x.x`
6. Push: `git push && git push --tags`
7. Publish: `flutter pub publish`

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for your contributions! 🎉