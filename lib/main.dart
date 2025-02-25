import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/widgets/forecast/forecast_tab_widget.dart';
import 'package:weatherapp/widgets/location/location_tab_widget.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ForecastProvider()),
    ChangeNotifierProvider(
        create: (context) => LocationProvider(
            Provider.of<ForecastProvider>(context, listen: false))),
  ], child: const MyApp()));
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'CS492 Weather App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            actions: [
            Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ],
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.sunny_snowing)),
              Tab(icon: Icon(Icons.edit_location_alt))
            ])),
        body: TabBarView(children: [ForecastTabWidget(), LocationTabWidget()]),
      ),
    );
  }
}
