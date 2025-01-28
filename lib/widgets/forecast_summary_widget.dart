import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;

class ForecastSummaryWidget extends StatelessWidget {
  const ForecastSummaryWidget({
    super.key,
    required forecast.Forecast currentForecast,
  }) : _forecast = currentForecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    // TODO: update this widget to look better
    // Use flutter documentation to help you
    // Try add spacing and a border around the outside
    // Update the text as well, so the name, forecast, and temperature have different formatting
    return Column(
      spacing: 16,
      children: [
        Text(_forecast.name ?? ""),
        Text("It is currently ${_forecast.shortForecast}"),
        Text("It is ${_forecast.temperature}${_forecast.temperatureUnit}")
      ],
    );
  }
}
