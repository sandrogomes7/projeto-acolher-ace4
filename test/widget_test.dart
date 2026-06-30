import 'package:flutter_test/flutter_test.dart';

import 'package:acolher_app/main.dart';

void main() {
  testWidgets('App inicia na tela de boas-vindas', (WidgetTester tester) async {
    await tester.pumpWidget(const ColoSeguroApp());
    await tester.pump();

    expect(find.text('Vamos te acompanhar'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
  });
}
