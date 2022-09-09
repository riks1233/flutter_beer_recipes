// ignore_for_file: prefer_const_constructors
import 'package:entain_beer_task_richardas/blocs/beers/beers_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeersEvent', () {
    group('BeersFetched', () {
      test('supports value comparison', () {
        expect(FetchBeers(), FetchBeers());
      });
    });
  });
}
