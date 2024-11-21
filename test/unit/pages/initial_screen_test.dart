import 'package:be_talent_alex_challengue/pages/home_screen.dart';
import 'package:be_talent_alex_challengue/pages/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'initial_screen_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  testWidgets('Should navigate to HomeScreen after 2 seconds',
      (WidgetTester tester) async {
    when(mockClient.get(any)).thenAnswer((_) async => http.Response('[]', 200));

    await tester.pumpWidget(
      MaterialApp(
        home: InitialScreen(client: mockClient),
      ),
    );

    expect(find.byType(InitialScreen), findsOneWidget);
    expect(
      find.byWidgetPredicate((widget) =>
          widget is RichText &&
          widget.text.toPlainText().contains('Be') &&
          widget.text.toPlainText().contains('Talent')),
      findsOneWidget,
    );

    await tester.pump(const Duration(seconds: 2));

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
