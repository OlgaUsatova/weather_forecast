import 'package:flutter/material.dart';
import 'package:weather_forecast/data/album_model.dart';
import 'package:weather_forecast/data/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WeatherModel> fetchWeather() {
    return WeatherProvider.fetchCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: FutureBuilder<WeatherModel>(
          future: fetchWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final model = snapshot.data;
              if (model == null) {
                return const Text('Нет данных');
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Icon(Icons.ac_unit),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(model.cityName),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("${model.temperature}"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
