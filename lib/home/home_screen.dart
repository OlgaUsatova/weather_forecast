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
    final theme = Theme.of(context);
    const myTextTheme = TextStyle(
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода'),
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
              return Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    child: Icon(Icons.add_chart),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            model.cityName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${model.temperature}",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                style: myTextTheme,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
