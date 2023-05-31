import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/views/daily_views_barrel.dart';

class DailyWeatherForecastScreen extends HookWidget {
  const DailyWeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDayNumber = useState<int>(0);
    final mockDataAvailableDays = useState<List<String>>(
      ["Test1", "Test2", "Test3", "Test4", "Test5", "Test6", "Test7"],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Daily Weather Forecast Header
              const DailyHeader(),
              Gap($styles.insets.sm),

              // Daily Weather Forecast Body
              DailyAvailableDays(
                availableDays: mockDataAvailableDays.value,
                selectedDayIndex: selectedDayNumber.value,
                onDayPressed: (index) async {
                  debugPrint("index -> $index");
                  selectedDayNumber.value = index;
                },
              ),

              // Daily Weather Forecast Body
              const DailyWeatherCard(
                weatherImage: 'assets/images/thunder_rain.svg',
                weatherDescription: "Rainy with thunder",
                temperatureMax: 37.5,
                temperatureMin: 21.7,
                windSpeed: 7.8,
                precipitationProbability: 11.5,
              ),

              // Daily Weather Forecast Footer
              const DailySunCard(
                sunriseTime: "04.37",
                sunsetTime: "17.22",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
