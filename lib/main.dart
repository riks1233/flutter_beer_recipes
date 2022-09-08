import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:entain_beer_task_richardas/ui/pages/beer_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Theme and styling lack dark mode support.
      // Colors are hardcoded.
      theme: ThemeData(
        applyElevationOverlayColor: false,
        useMaterial3: true,
        fontFamily: "GoogleSans",
        backgroundColor: Colors.grey.shade300,
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.grey.shade700),
      ),
      home: const BeerListPage(),
    );
  }
}
