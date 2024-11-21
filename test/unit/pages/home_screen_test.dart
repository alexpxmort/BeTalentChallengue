import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:be_talent_alex_challengue/pages/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('HomeScreen Widget Tests', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    testWidgets('Should display CircularProgressIndicator while loading',
        (WidgetTester tester) async {
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response('[]', 200));

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(client: mockClient),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Should display data correctly after loading',
        (WidgetTester tester) async {
      const mockApiResponse = '''
      [
        {"name": "John Doe", "job": "Developer", "admission_date": "2022-01-01", "phone": "123456789"},
        {"name": "Jane Smith", "job": "Designer", "admission_date": "2021-06-15", "phone": "987654321"}
      ]
      ''';

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(mockApiResponse, 200));

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(client: mockClient),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
    });

    testWidgets('Should filter results when searching',
        (WidgetTester tester) async {
      const mockApiResponse = '''
      [
        {"name": "John Doe", "job": "Developer", "admission_date": "2022-01-01", "phone": "123456789"},
        {"name": "Jane Smith", "job": "Designer", "admission_date": "2021-06-15", "phone": "987654321"}
      ]
      ''';

      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(mockApiResponse, 200));

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(client: mockClient),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'John');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsNothing);
    });
  });
}
