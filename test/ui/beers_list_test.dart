import 'package:bloc_test/bloc_test.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list_tile.dart';
import 'package:entain_beer_task_richardas/ui/widgets/progress_indicator_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:entain_beer_task_richardas/blocs/beers/beers_bloc.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list.dart';

class MockBeersBloc extends MockBloc<BeersEvent, BeersState>
    implements BeersBloc {}

extension on WidgetTester {
  Future<void> pumpBeerList(BeersBloc beersBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: beersBloc,
          child: const BeerList(),
        ),
      ),
    );
  }
}

void main() {
  final mockBeers = List.generate(
      5,
      (i) => Beer(
          id: i,
          name: 'Walter',
          ingredients: const Ingredients(malt: <Malt>[
            Malt(name: 'Caramalt', amount: Volume(value: 2, unit: 'kilograms'))
          ], yeast: 'Wyeast')));

  late BeersBloc beersBloc;

  setUp(() {
    beersBloc = MockBeersBloc();
  });

  group('BeerList', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when beers status is initial', (tester) async {
      when(() => beersBloc.state).thenReturn(const BeersState());
      await tester.pumpBeerList(beersBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders no beers text '
        'when beer status is success but with 0 beers', (tester) async {
      when(() => beersBloc.state).thenReturn(
        const BeersState(status: BeersStatus.success, hasReachedMax: true),
      );
      await tester.pumpBeerList(beersBloc);
      expect(find.text('No beers today.'), findsOneWidget);
    });

    testWidgets(
        'renders 5 beers and a bottom loader when beers max is not reached yet',
        (tester) async {
      when(() => beersBloc.state).thenReturn(
        BeersState(
          status: BeersStatus.success,
          beers: mockBeers,
        ),
      );
      await tester.pumpBeerList(beersBloc);
      expect(find.byType(BeerListTile), findsNWidgets(5));
      expect(find.byType(ProgressIndicatorListTile), findsOneWidget);
    });

    testWidgets('does not render bottom loader when beers max is reached',
        (tester) async {
      when(() => beersBloc.state).thenReturn(
        BeersState(
          status: BeersStatus.success,
          beers: mockBeers,
          hasReachedMax: true,
        ),
      );
      await tester.pumpBeerList(beersBloc);
      expect(find.byType(ProgressIndicatorListTile), findsNothing);
    });

    testWidgets('fetches more beers when scrolled to the bottom',
        (tester) async {
      when(() => beersBloc.state).thenReturn(
        BeersState(
          status: BeersStatus.success,
          beers: List.generate(
              20,
              (i) => Beer(
                  id: i,
                  name: 'Walter',
                  ingredients: const Ingredients(malt: <Malt>[
                    Malt(
                        name: 'Caramalt',
                        amount: Volume(value: 2, unit: 'kilograms'))
                  ], yeast: 'Wyeast'))),
        ),
      );
      await tester.pumpBeerList(beersBloc);
      await tester.drag(find.byType(BeerList), const Offset(0, -2000));
      verify(() => beersBloc.add(FetchBeers())).called(1);
    });
  });
}
