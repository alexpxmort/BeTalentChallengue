import 'package:flutter/material.dart';
import 'package:be_talent_alex_challengue/widgets/search_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchInput Widget Tests', () {
    testWidgets('Should display the search field and icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onSearch: (_) async {},
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('Should call onSearch with the correct input',
        (WidgetTester tester) async {
      String searchQuery = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchInput(
              onSearch: (query) async {
                searchQuery = query;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Flutter');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();

      expect(searchQuery, 'Flutter');
    });
  });
}
