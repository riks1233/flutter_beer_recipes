
import 'package:entain_beer_task_richardas/ui/pages/beer_details_page.dart';
import 'package:entain_beer_task_richardas/ui/pages/beers_list_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "GoogleSans",
        backgroundColor: Colors.grey.shade300,
      ),
      home: const BeersListPage(),
    );
  }
}
