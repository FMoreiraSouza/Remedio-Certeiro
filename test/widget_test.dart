import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remedio_certeiro/main.dart';

void main() {
  testWidgets('Interface renderizada corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Remédio Certeiro'), findsOneWidget);

    expect(find.byIcon(Icons.medical_information), findsOneWidget);

    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Descrição'), findsOneWidget);
    expect(find.text('Modo de uso'), findsOneWidget);

    expect(find.text('Aplicar medicamento'), findsOneWidget);

    await tester.tap(find.text('Aplicar medicamento'));
    await tester.pump();
    expect(find.text('Medicamento aplicado!'), findsOneWidget);
  });
}
