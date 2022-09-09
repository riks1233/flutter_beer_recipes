import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entain_beer_task_richardas/constants.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';

part 'beers_event.dart';
part 'beers_state.dart';

const _throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BeersBloc extends Bloc<BeersEvent, BeersState> {
  BeersBloc({required this.dio}) : super(const BeersState()) {
    on<FetchBeers>(
      _onFetchBeers,
      transformer: throttleDroppable(_throttleDuration),
    );
  }

  /// [Dio] instance is needed as an argument so that API
  /// calls are testable.
  final Dio dio;

  Future<void> _onFetchBeers(
      FetchBeers event, Emitter<BeersState> emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == BeersStatus.initial) {
        final beers = await _fetchBeers(page: 1);
        return emit(
          state.copyWith(
            status: BeersStatus.success,
            beers: beers,
            hasReachedMax: false,
          ),
        );
      }
      // Consider all number of items the API might return:
      //  - Full list of beers (i.e. requested number of beers per page).
      //  - Non-full list of beers.
      //  - Empty list of beers.
      int nextPage = state.beers.length ~/ Constants.beersApiBeersPerPage + 1;
      bool lastPageReturnedFullList = state.beers.length % Constants.beersApiBeersPerPage == 0;
      if (!lastPageReturnedFullList) {
        nextPage += 1;
      }
      final beers = await _fetchBeers(page: nextPage);
      final hasReachedMax = beers.isEmpty;
      emit(
        state.copyWith(
          status: BeersStatus.success,
          beers: List.of(state.beers)..addAll(beers),
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: BeersStatus.failure));
    }
  }

  Future<List<Beer>> _fetchBeers({required int page}) async {
    final response = await dio.getUri(
      Uri.https(
        Constants.beersApiAuthority,
        Constants.beersApiEndpointPath,
        <String, String>{
          'page': page.toString(),
          'per_page': Constants.beersApiBeersPerPage.toString()
        }
      )
    );

    if (response.statusCode == 200) {
      List<dynamic> beersJsonList = response.data;
      List<Beer> beers =
          beersJsonList.map((beerJson) => Beer.fromJson(beerJson)).toList();
      return beers;
    }
    throw Exception('Error fetching beers.');
  }
}
