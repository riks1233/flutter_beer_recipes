import 'package:entain_beer_task_richardas/ui/pages/beer_list_page.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeerListPage', () {
    testWidgets('renders BeersList', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: BeerListPage()));
      await tester.pumpAndSettle();
      expect(find.byType(BeerList), findsOneWidget);
    });
  });
}
