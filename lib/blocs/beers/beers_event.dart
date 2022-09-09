part of 'beers_bloc.dart';

abstract class BeersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBeers extends BeersEvent {}
