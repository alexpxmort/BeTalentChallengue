import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:be_talent_alex_challengue/widgets/table/table_header.dart';

void main() {
  group('TableHeader Widget Tests', () {
    testWidgets('Should display headers correctly',
        (WidgetTester tester) async {
      const headers = ['Name', 'Age', 'Location'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TableHeader(headers: headers),
          ),
        ),
      );

      for (final header in headers) {
        expect(find.text(header.toUpperCase()), findsOneWidget);
      }
    });

    testWidgets('Should display trailing icon if provided',
        (WidgetTester tester) async {
      const headers = ['Name', 'Age'];
      const trailingIcon = Icon(Icons.more_vert);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TableHeader(headers: headers, trailingIcon: trailingIcon),
          ),
        ),
      );

      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('Should not display trailing icon if not provided',
        (WidgetTester tester) async {
      const headers = ['Name', 'Age'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TableHeader(headers: headers),
          ),
        ),
      );

      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('Should respect layout constraints',
        (WidgetTester tester) async {
      const headers = ['Header1', 'Header2'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TableHeader(headers: headers),
          ),
        ),
      );

      final container = tester.firstWidget(find.byType(Container)) as Container;
      expect(container.constraints?.maxWidth, double.infinity);
    });
  });
}
