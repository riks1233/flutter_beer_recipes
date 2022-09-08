import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:entain_beer_task_richardas/blocs/beers/beers_bloc.dart';
import 'package:entain_beer_task_richardas/ui/pages/page_wrapper.dart';
import 'package:entain_beer_task_richardas/ui/widgets/beer_list/beer_list.dart';

class BeerListPage extends StatelessWidget {
  const BeerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: BlocProvider(
        create: (_) => BeersBloc()..add(BeersFetched()),
        child: const BeerList(),
      ),
    );
  }
}

