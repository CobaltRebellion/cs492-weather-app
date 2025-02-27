import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:weatherapp/providers/settings_provider.dart';
import 'package:weatherapp/widgets/forecast/forecast_tab_widget.dart';
import 'package:weatherapp/widgets/location/location_tab_widget.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/themes/themes.dart' as themes;

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ForecastProvider()),
    ChangeNotifierProvider(
        create: (context) => LocationProvider(
            Provider.of<ForecastProvider>(context, listen: false))),
    ChangeNotifierProvider(create: (context) => SettingsProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'CS492 Weather App';

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: title,
      theme: themes.lightTheme,
      darkTheme: themes.darkTheme,
      themeMode: settingsProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
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
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        endDrawer: SettingsDrawer(settingsProvider: settingsProvider),
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              SettingsButton()
            ],
            title: Text(widget.title),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.sunny_snowing)),
              Tab(icon: Icon(Icons.edit_location_alt))
            ])),
        body: TabBarView(children: [ForecastTabWidget(), LocationTabWidget()]),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        });
  }
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    super.key,
    required this.settingsProvider,
  });

  final SettingsProvider settingsProvider;

  void _pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = settingsProvider.themeColor;
        return AlertDialog(
          title: Text("Pick a theme color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (color) {
                tempColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Select"),
              onPressed: () {
                settingsProvider.setThemeColor(tempColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Switch(
              value: settingsProvider.darkMode,
              onChanged: (bool value) {
                settingsProvider.toggleMode();
              }),
          ListTile(
            title: Text("Theme Color"),
            trailing: Icon(Icons.color_lens, color: settingsProvider.themeColor),
            onTap: () => _pickColor(context),
          )
        ],
      ),
    );
  }
}
