import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gudanbridge_care/app.dart';

void main() {
  testWidgets('GudanBridge Care - tela inicial renderiza corretamente',
          (WidgetTester tester) async {
        // Monta o app com ProviderScope (necessário para Riverpod)
        await tester.pumpWidget(
          const ProviderScope(
            child: GudanBridgeApp(),
          ),
        );

        // Verifica se o título da página de check-in apareceu
        expect(find.text('Como você está hoje?'), findsOneWidget);

        // Verifica se o slider de humor existe
        expect(find.byType(Slider), findsWidgets);

        // Verifica se o botão 'Registrar check-in' existe
        expect(find.text('Registrar check-in'), findsOneWidget);

        // Verifica se o bottom navigation bar existe com as 4 abas
        expect(find.text('Check-in'), findsOneWidget);
        expect(find.text('Jornadas'), findsOneWidget);
        expect(find.text('Metas'), findsOneWidget);
        expect(find.text('Insights'), findsOneWidget);
      });
}
