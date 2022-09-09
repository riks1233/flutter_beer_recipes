import 'package:entain_beer_task_richardas/main.dart';
import 'package:entain_beer_task_richardas/ui/pages/beer_list_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders BeersListPage', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(BeerListPage), findsOneWidget);
    });
  });
}
