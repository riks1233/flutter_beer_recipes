import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:entain_beer_task_richardas/blocs/beers/beers_bloc.dart';
import 'package:entain_beer_task_richardas/constants.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

Uri _beersUrl({required int page}) {
  return Uri.https(
    Constants.beersApiAuthority,
    Constants.beersApiEndpointPath,
    <String, String>{
      'page': page.toString(),
      'per_page': Constants.beersApiBeersPerPage.toString()
    }
  );
}

Response _mockSuccsessfulResponse() {
  return Response(
    statusCode: 200,
    // `path` does not matter for us.
    requestOptions: RequestOptions(path: ''),
    data: jsonDecode(
      '''[{
          "id": 1,
          "name": "Walter",
          "ingredients": {
              "malt": [
                  {
                      "name": "Caramalt",
                      "amount": {
                          "value": 2,
                          "unit": "kilograms"
                      }
                  }
              ],
              "yeast": "Wyeast"
          }
      }]''',
    ),
  );
}

void main() {
  group('BeersBloc', () {
    late MockDio dio;

    final List<Beer> mockBeers = [
      const Beer(
        id: 1,
        name: 'Walter',
        ingredients: Ingredients(
          malt: <Malt>[
            Malt(name: 'Caramalt', amount: Volume(value: 2, unit: 'kilograms'))
          ],
          yeast: 'Wyeast'
        )
      )
    ];

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      dio = MockDio();
    });

    test('initial state is BeersState()', () {
      expect(BeersBloc(dio: dio).state, const BeersState());
    });

    group('FetchBeers', () {
      blocTest<BeersBloc, BeersState>(
        'emits nothing when beers has reached maximum amount',
        build: () => BeersBloc(dio: dio),
        seed: () => const BeersState(hasReachedMax: true),
        act: (bloc) => bloc.add(FetchBeers()),
        expect: () => <BeersState>[],
      );

      blocTest<BeersBloc, BeersState>(
        'emits successful status when dio fetches initial beers',
        setUp: () {
          when(() => dio.getUri(any())).thenAnswer((_) async {
            return _mockSuccsessfulResponse();
          });
        },
        build: () => BeersBloc(dio: dio),
        act: (bloc) => bloc.add(FetchBeers()),
        expect: () => <BeersState>[
          BeersState(status: BeersStatus.success, beers: mockBeers)
        ],
        verify: (_) {
          verify(() => dio.getUri(_beersUrl(page: 1))).called(1);
        },
      );

      blocTest<BeersBloc, BeersState>(
        'drops new events when processing current event',
        setUp: () {
          when(() => dio.getUri(any())).thenAnswer((_) async {
            return _mockSuccsessfulResponse();
          });
        },
        build: () => BeersBloc(dio: dio),
        act: (bloc) => bloc
          ..add(FetchBeers())
          ..add(FetchBeers()),
        expect: () => <BeersState>[
          BeersState(status: BeersStatus.success, beers: mockBeers)
        ],
        verify: (_) {
          verify(() => dio.getUri(any())).called(1);
        },
      );

      blocTest<BeersBloc, BeersState>(
        'emits failure status when dio fetches beers and throws exception',
        setUp: () {
          when(() => dio.getUri(any())).thenAnswer(
            (_) async => Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: ''),
              data: ''
            ),
          );
        },
        build: () => BeersBloc(dio: dio),
        act: (bloc) => bloc.add(FetchBeers()),
        expect: () => <BeersState>[const BeersState(status: BeersStatus.failure)],
        verify: (_) {
          verify(() => dio.getUri(any())).called(1);
        },
      );

      blocTest<BeersBloc, BeersState>(
        'emits successful status and reaches max beers when '
        '0 additional beers are fetched',
        setUp: () {
          when(() => dio.getUri(any())).thenAnswer(
            (_) async => Response(
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
              data: jsonDecode('[]')
            ),
          );
        },
        build: () => BeersBloc(dio: dio),
        seed: () => BeersState(
          status: BeersStatus.success,
          beers: mockBeers,
        ),
        act: (bloc) => bloc.add(FetchBeers()),
        expect: () => <BeersState>[
          BeersState(
            status: BeersStatus.success,
            beers: mockBeers,
            hasReachedMax: true,
          )
        ],
        verify: (_) {
          verify(() => dio.getUri(any())).called(1);
        },
      );

      blocTest<BeersBloc, BeersState>(
        'throttles events',
        setUp: () {
          when(() => dio.getUri(any())).thenAnswer((_) async {
            return _mockSuccsessfulResponse();
          });
        },
        build: () => BeersBloc(dio: dio),
        act: (bloc) async {
          bloc.add(FetchBeers());
          await Future<void>.delayed(Duration.zero);
          bloc.add(FetchBeers());
        },
        expect: () => <BeersState>[
          BeersState(status: BeersStatus.success, beers: mockBeers)
        ],
        verify: (_) {
          verify(() => dio.getUri(any())).called(1);
        },
      );
    });
  });
}
