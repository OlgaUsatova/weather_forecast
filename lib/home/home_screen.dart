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
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          FutureBuilder<WeatherModel>(
            future: fetchWeather(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final model = snapshot.data;
                if (model == null) {
                  return const Center(
                    child: Text('Нет данных'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        model.cityName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Температура:\n'
                        "${model.temperature}",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Как ощущается:\n'
                        "${model.feelsLike}",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Ясно или облачно:\n'
                        "${model.description}",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Дата и время:\n'
                        "${model.time}",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
        ],
      ),
    );
  }
}
