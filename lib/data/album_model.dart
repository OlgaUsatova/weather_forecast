class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String iconCode;
  final String description;
  final DateTime time;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.iconCode,
    required this.description,
    required this.time,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: double.parse(json['main']['temp'].toString()),
      feelsLike: double.parse(json['main']['temp'].toString()),
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['main'],
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
