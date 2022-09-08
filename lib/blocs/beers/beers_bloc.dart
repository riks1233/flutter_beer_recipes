import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';

part 'beers_event.dart';
part 'beers_state.dart';

const _endpointUrl = 'https://api.punkapi.com/v2/beers';
const _beersPerPage = 20;
const _throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BeersBloc extends Bloc<BeersEvent, BeersState> {
  BeersBloc() : super(const BeersState()) {
    on<BeersFetched>(
      _onBeersFetched,
      transformer: throttleDroppable(_throttleDuration),
    );
  }

  Future<void> _onBeersFetched(
      BeersFetched event, Emitter<BeersState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == BeersStatus.initial) {
        final beers = await _fetchBeers();
        return emit(
          state.copyWith(
            status: BeersStatus.success,
            beers: beers,
            hasReachedMax: false,
          ),
        );
      }
      final nextPage = state.beers.length ~/ _beersPerPage + 1;
      final beers = await _fetchBeers(page: nextPage);
      final hasReachedMax = beers.isEmpty || beers.length < _beersPerPage;
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

  Future<List<Beer>> _fetchBeers({int page = 1}) async {
    final response = await Dio().get(_endpointUrl,
        queryParameters: {'page': page, 'per_page': _beersPerPage});
    if (response.statusCode == 200) {
      List<dynamic> beersJsonList = response.data;
      List<Beer> beers =
          beersJsonList.map((beerJson) => Beer.fromJson(beerJson)).toList();
      return beers;
    }
    throw Exception('Error fetching beers.');
  }
}
