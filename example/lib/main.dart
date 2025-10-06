// ============================================================================
// FILE: example/lib/main.dart (Example App)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:enhanced_split_view/enhanced_split_view.dart';

void main() => runApp(const SplitViewExampleApp());

class SplitViewExampleApp extends StatelessWidget {
  const SplitViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Split View Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  int _selectedIndex = 0;

  final List<Example> _examples = const [
    Example('Basic 2-Pane', BasicExample()),
    Example('3-Pane Split', ThreePaneExample()),
    Example('Vertical Split', VerticalExample()),
    Example('Nested Splits', NestedExample()),
    Example('Custom Styling', CustomStyleExample()),
    Example('IDE Layout', IDELayoutExample()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Split View Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) =>
                setState(() => _selectedIndex = index),
            labelType: NavigationRailLabelType.all,
            destinations: _examples
                .map(
                  (e) => NavigationRailDestination(
                    icon: const Icon(Icons.view_column),
                    label: Text(e.title),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _examples[_selectedIndex].widget),
        ],
      ),
    );
  }
}

class Example {
  final String title;
  final Widget widget;
  const Example(this.title, this.widget);
}

// Example 1: Basic 2-Pane
class BasicExample extends StatelessWidget {
  const BasicExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Basic 2-Pane Split',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SplitView(
              direction: SplitDirection.horizontal,
              children: [
                _buildPane('Left Pane', Colors.blue.shade100),
                _buildPane('Right Pane', Colors.green.shade100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPane(String text, Color color) {
    return Container(
      color: color,
      child: Center(child: Text(text, style: const TextStyle(fontSize: 20))),
    );
  }
}

// Example 2: 3-Pane Split
class ThreePaneExample extends StatefulWidget {
  const ThreePaneExample({super.key});

  @override
  State<ThreePaneExample> createState() => _ThreePaneExampleState();
}

class _ThreePaneExampleState extends State<ThreePaneExample> {
  String _weights = '33% : 34% : 33%';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('3-Pane Split',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Current weights: $_weights'),
              const SizedBox(height: 4),
              const Text(
                'Drag divider 1 to resize Left/Center. Drag divider 2 to resize Center/Right.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SplitView(
              direction: SplitDirection.horizontal,
              initialWeights: const [0.25, 0.5, 0.25],
              onWeightsChanged: (weights) {
                setState(() {
                  _weights = weights
                      .map((w) => '${(w * 100).toStringAsFixed(1)}%')
                      .join(' : ');
                });
                print('Weights changed: $weights'); // Debug output
              },
              children: [
                _buildPane('Left\n25%', Colors.red.shade100, 'Pane 1'),
                _buildPane('Center\n50%', Colors.blue.shade100, 'Pane 2'),
                _buildPane('Right\n25%', Colors.green.shade100, 'Pane 3'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPane(String text, Color color, String label) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Example 3: Vertical Split
class VerticalExample extends StatelessWidget {
  const VerticalExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Vertical Split',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SplitView(
              direction: SplitDirection.vertical,
              children: [
                _buildPane('Top Pane', Colors.purple.shade100),
                _buildPane('Bottom Pane', Colors.orange.shade100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPane(String text, Color color) {
    return Container(
      color: color,
      child: Center(child: Text(text, style: const TextStyle(fontSize: 20))),
    );
  }
}

// Example 4: Nested Splits
class NestedExample extends StatelessWidget {
  const NestedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Nested Splits',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SplitView(
              direction: SplitDirection.horizontal,
              initialWeights: const [0.3, 0.7],
              children: [
                _buildPane('Sidebar', Colors.blue.shade100),
                SplitView(
                  direction: SplitDirection.vertical,
                  children: [
                    _buildPane('Main Content', Colors.green.shade100),
                    _buildPane('Footer', Colors.orange.shade100),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPane(String text, Color color) {
    return Container(
      color: color,
      child: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
    );
  }
}

// Example 5: Custom Styling
class CustomStyleExample extends StatelessWidget {
  const CustomStyleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Custom Styling',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text('Thick divider with custom colors'),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SplitView(
              direction: SplitDirection.horizontal,
              dividerStyle: const DividerStyle(
                width: 20,
                color: Color(0xFF6200EA),
                hoverColor: Color(0xFFB388FF),
                handleSize: 60,
              ),
              children: [
                _buildPane('Purple Theme', Colors.purple.shade50),
                _buildPane('Hover to see effect', Colors.deepPurple.shade50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPane(String text, Color color) {
    return Container(
      color: color,
      child: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
    );
  }
}

// Example 6: IDE Layout
class IDELayoutExample extends StatelessWidget {
  const IDELayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'IDE Layout',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SplitView(
              direction: SplitDirection.vertical,
              initialWeights: const [0.75, 0.25],
              children: [
                SplitView(
                  direction: SplitDirection.horizontal,
                  initialWeights: const [0.2, 0.6, 0.2],
                  children: [
                    _buildIDEPane(
                      'File Explorer',
                      Icons.folder,
                      Colors.blue.shade100,
                    ),
                    _buildIDEPane('Editor', Icons.code, Colors.grey.shade50),
                    _buildIDEPane(
                      'Properties',
                      Icons.settings,
                      Colors.orange.shade100,
                    ),
                  ],
                ),
                _buildIDEPane('Console', Icons.terminal, Colors.black87, true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIDEPane(
    String text,
    IconData icon,
    Color color, [
    bool isDark = false,
  ]) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: isDark ? Colors.white : Colors.black54),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
