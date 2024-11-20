import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:be_talent_alex_challengue/widgets/table/table_row.dart';

void main() {
  testWidgets('CustomTableRow displays data and expands correctly',
      (WidgetTester tester) async {
    final Map<String, dynamic> data = {
      'Foto': null,
      'Nome': 'John',
      'Idade': 30,
      'Cidade': 'São Paulo',
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTableRow(data: data),
        ),
      ),
    );

    expect(find.text('John'), findsOneWidget);

    expect(find.byType(Table), findsNothing);

    await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
    await tester.pump();

    expect(find.byType(Table), findsOneWidget);

    expect(find.text('Idade'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('Cidade'), findsOneWidget);
    expect(find.text('São Paulo'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.keyboard_arrow_up));
    await tester.pump();

    expect(find.byType(Table), findsNothing);
  });
}
