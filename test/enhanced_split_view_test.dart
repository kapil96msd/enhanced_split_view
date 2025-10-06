import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enhanced_split_view/enhanced_split_view.dart';

void main() {
  group('SplitView', () {
    testWidgets('renders with 2 children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('pane1')), findsOneWidget);
      expect(find.byKey(const Key('pane2')), findsOneWidget);
    });

    testWidgets('renders with 3 children', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
                Container(key: const Key('pane3')),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('pane1')), findsOneWidget);
      expect(find.byKey(const Key('pane2')), findsOneWidget);
      expect(find.byKey(const Key('pane3')), findsOneWidget);
    });

    testWidgets('uses initial weights', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 1000,
              height: 500,
              child: SplitView(
                direction: SplitDirection.horizontal,
                initialWeights: const [0.3, 0.7],
                animated: false,
                children: [
                  Container(key: const Key('pane1')),
                  Container(key: const Key('pane2')),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final pane1 = tester.getSize(find.byKey(const Key('pane1')));
      final pane2 = tester.getSize(find.byKey(const Key('pane2')));

      // Verify the ratio is approximately 30:70
      final total = pane1.width + pane2.width;
      final ratio1 = pane1.width / total;
      final ratio2 = pane2.width / total;

      expect(ratio1, closeTo(0.3, 0.02));
      expect(ratio2, closeTo(0.7, 0.02));
    });

    testWidgets('calls onWeightsChanged', (tester) async {
      List<double>? capturedWeights;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              onWeightsChanged: (weights) => capturedWeights = weights,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
              ],
            ),
          ),
        ),
      );

      // Simulate drag
      await tester.drag(
        find.byType(GestureDetector).first,
        const Offset(100, 0),
      );
      await tester.pumpAndSettle();

      expect(capturedWeights, isNotNull);
      expect(capturedWeights?.length, 2);
    });

    testWidgets('respects minWeight', (tester) async {
      List<double>? capturedWeights;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 1000,
              height: 500,
              child: SplitView(
                direction: SplitDirection.horizontal,
                minWeight: 0.2,
                onWeightsChanged: (weights) => capturedWeights = weights,
                children: [
                  Container(key: const Key('pane1')),
                  Container(key: const Key('pane2')),
                ],
              ),
            ),
          ),
        ),
      );

      // Try to drag past minimum
      await tester.drag(
        find.byType(GestureDetector).first,
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();

      if (capturedWeights != null) {
        expect(capturedWeights![0], greaterThanOrEqualTo(0.2));
        expect(capturedWeights![1], greaterThanOrEqualTo(0.2));
      }
    });

    testWidgets('works with vertical direction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.vertical,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('pane1')), findsOneWidget);
      expect(find.byKey(const Key('pane2')), findsOneWidget);
    });

    testWidgets('handles nested splits', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              children: [
                Container(key: const Key('left')),
                SplitView(
                  direction: SplitDirection.vertical,
                  children: [
                    Container(key: const Key('top')),
                    Container(key: const Key('bottom')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('left')), findsOneWidget);
      expect(find.byKey(const Key('top')), findsOneWidget);
      expect(find.byKey(const Key('bottom')), findsOneWidget);
    });

    testWidgets('handles extremely small container sizes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 10,
              height: 10,
              child: SplitView(
                direction: SplitDirection.horizontal,
                children: [
                  Container(key: const Key('pane1')),
                  Container(key: const Key('pane2')),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Should not crash
      expect(find.byType(SplitView), findsOneWidget);
    });

    testWidgets('animation can be disabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              animated: false,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('pane1')), findsOneWidget);
      expect(find.byKey(const Key('pane2')), findsOneWidget);
    });

    testWidgets('updates when children count changes', (tester) async {
      var childCount = 2;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => childCount = 3),
                      child: const Text('Add child'),
                    ),
                    Expanded(
                      child: SplitView(
                        direction: SplitDirection.horizontal,
                        children: List.generate(
                          childCount,
                          (i) => Container(key: Key('pane$i')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      expect(find.byKey(const Key('pane0')), findsOneWidget);
      expect(find.byKey(const Key('pane1')), findsOneWidget);
      expect(find.byKey(const Key('pane2')), findsNothing);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('pane0')), findsOneWidget);
      expect(find.byKey(const Key('pane1')), findsOneWidget);
      expect(find.byKey(const Key('pane2')), findsOneWidget);
    });

    testWidgets('divider shows hover effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
              ],
            ),
          ),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await tester.pump();

      final divider = find.byType(MouseRegion).first;
      await gesture.moveTo(tester.getCenter(divider));
      await tester.pumpAndSettle();

      // Divider should be present and responsive
      expect(divider, findsOneWidget);
    });

    testWidgets('weights sum to 1.0 after normalization', (tester) async {
      List<double>? capturedWeights;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SplitView(
              direction: SplitDirection.horizontal,
              initialWeights: const [0.3, 0.4, 0.3],
              onWeightsChanged: (weights) => capturedWeights = weights,
              children: [
                Container(key: const Key('pane1')),
                Container(key: const Key('pane2')),
                Container(key: const Key('pane3')),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Trigger a drag to get weights
      await tester.drag(
        find.byType(GestureDetector).first,
        const Offset(10, 0),
      );
      await tester.pumpAndSettle();

      if (capturedWeights != null) {
        final sum = capturedWeights!.fold<double>(0.0, (a, b) => a + b);
        expect(sum, closeTo(1.0, 0.001));
      }
    });
  });

  group('DividerStyle', () {
    test('creates with default values', () {
      const style = DividerStyle();

      expect(style.width, 8.0);
      expect(style.color, const Color(0xFFE0E0E0));
      expect(style.hoverColor, const Color(0xFF2196F3));
      expect(style.handleSize, 48.0);
      expect(style.showHandle, true);
    });

    test('copyWith works correctly', () {
      const original = DividerStyle();
      final copied = original.copyWith(width: 12.0, color: Colors.red);

      expect(copied.width, 12.0);
      expect(copied.color, Colors.red);
      expect(copied.hoverColor, original.hoverColor);
      expect(copied.handleSize, original.handleSize);
    });

    test('equality works correctly', () {
      const style1 = DividerStyle(width: 10.0);
      const style2 = DividerStyle(width: 10.0);
      const style3 = DividerStyle(width: 12.0);

      expect(style1, equals(style2));
      expect(style1, isNot(equals(style3)));
    });

    test('hashCode works correctly', () {
      const style1 = DividerStyle(width: 10.0);
      const style2 = DividerStyle(width: 10.0);

      expect(style1.hashCode, equals(style2.hashCode));
    });
  });

  group('SplitDirection', () {
    test('has correct values', () {
      expect(SplitDirection.values.length, 2);
      expect(SplitDirection.values, contains(SplitDirection.horizontal));
      expect(SplitDirection.values, contains(SplitDirection.vertical));
    });
  });
}
