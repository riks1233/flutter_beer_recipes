part of 'beers_bloc.dart';

enum BeersStatus { initial, success, failure }

class BeersState extends Equatable {
  const BeersState({
    this.status = BeersStatus.initial,
    this.beers = const <Beer>[],
    this.hasReachedMax = false,
  });

  final BeersStatus status;
  final List<Beer> beers;
  final bool hasReachedMax;

  BeersState copyWith({
    BeersStatus? status,
    List<Beer>? beers,
    bool? hasReachedMax,
  }) {
    return BeersState(
      status: status ?? this.status,
      beers: beers ?? this.beers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, beers, hasReachedMax];
}
