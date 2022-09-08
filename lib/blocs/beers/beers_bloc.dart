import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';
import 'package:entain_beer_task_richardas/models/beer/beer.dart';

part 'beers_event.dart';
part 'beers_state.dart';


const _beerLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BeersBloc extends Bloc<BeersEvent, BeersState> {
  BeersBloc() :
    httpClient = "asd", // TODO: Initialize DIO
    super(const BeersState()) {
      on<BeersFetched>(
        _onBeersFetched,
        transformer: throttleDroppable(throttleDuration),
      );
    }

  // final http.Client httpClient;
  final String httpClient;

  Future<void> _onBeersFetched(BeersFetched event, Emitter<BeersState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == BeersStatus.initial) {
        final beers = await _fetchBeers();
        return emit(
          state.copyWith(
            status: BeersStatus.success,
            beers: beers,
            hasReachedMax: true,
          ),
        );
      }
      // final beers = await _fetchBeers(state.beers.length);
      // beers.isEmpty
      //     ? emit(state.copyWith(hasReachedMax: true))
      //     : emit(
      //         state.copyWith(
      //           status: BeersStatus.success,
      //           beers: List.of(state.beers)..addAll(beers),
      //           hasReachedMax: false,
      //         ),
      //       );
    } catch (_) {
      emit(state.copyWith(status: BeersStatus.failure));
    }
  }

  Future<List<Beer>> _fetchBeers([int startIndex = 0]) async {
    String beersJson = await rootBundle.loadString('assets/sample_data.json');
    List<dynamic> beersJsonList = jsonDecode(beersJson);
    List<Beer> beers =
        beersJsonList.map((beerJson) => Beer.fromJson(beerJson)).toList();
    return beers;

    // final response = await httpClient.get(
    //   Uri.https(
    //     'jsonplaceholder.typicode.com',
    //     '/beers',
    //     <String, String>{'_start': '$startIndex', '_limit': '$_beerLimit'},
    //   ),
    // );
    // if (response.statusCode == 200) {
    //   final body = json.decode(response.body) as List;
    //   return body.map((dynamic json) {
    //     final map = json as Map<String, dynamic>;
    //     return Beer(
    //       id: map['id'] as int
    //     );
    //   }).toList();
    // }
    // throw Exception('Error fetching beers.');
  }
}
