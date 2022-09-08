import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:entain_beer_task_richardas/blocs/beers/beers_bloc.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list_tile.dart';
import 'package:entain_beer_task_richardas/ui/widgets/progress_indicator_list_tile.dart';

class BeerList extends StatefulWidget {
  const BeerList({super.key});

  @override
  State<BeerList> createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<BeersBloc>().add(BeersFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BeersBloc, BeersState>(
      builder: (context, state) {
        switch (state.status) {
          case BeersStatus.failure:
            return const Center(child: Text('Failed to fetch beers.'));
          case BeersStatus.success:
            if (state.beers.isEmpty) {
              return const Center(child: Text('No beers today.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: state.hasReachedMax
                  ? state.beers.length
                  : state.beers.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  // Insert a padding divider.
                  return const SizedBox(
                    height: 8,
                  );
                }
                return index < state.beers.length
                    ? BeerListTile(beer: state.beers[index])
                    : const ProgressIndicatorListTile();
              },
              controller: _scrollController,
            );
          case BeersStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
