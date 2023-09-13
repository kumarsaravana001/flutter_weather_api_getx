import 'package:flutter/material.dart';
import 'package:flutter_application_weather_app/controller/weather_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final WeatherController weatherController = Get.put(WeatherController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (city) {
                if (city.isNotEmpty) {
                  weatherController.fetchWeather(city);
                }
              },
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    weatherController.weatherData.value = {};
                  },
                ),
              ),
            ),
            Obx(() {
              final weatherData = weatherController.weatherData;

              if (weatherData.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Enter a city to get weather data'),
                  ),
                );
              } else {
                final temperature =
                    (weatherData['main']['temp'] - 273.15).toStringAsFixed(2);
                final description = weatherData['weather'][0]['description'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.all(10)),
                    Row(
                      children: [
                        Text('Temperature:$temperature°C'),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            _getTemperatureEmoji(
                              double.parse(temperature),
                            ),
                            style: const TextStyle(fontSize: 24.0),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text('Description: $description'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _getDescriptionEmoji(description),
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text('Humidity: ${weatherData['main']['humidity']}%'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _getHumidityEmoji(
                                  weatherData['main']['humidity']),
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text(
                              'Wind Speed: ${weatherData['wind']['speed']} m/s'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _getWindSpeedEmoji(double.parse(
                                  weatherData['wind']['speed'].toString())),
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  String _getTemperatureEmoji(double temperature) {
    if (temperature > 30) {
      return '🔥';
    } else if (temperature < 10) {
      return '❄️';
    } else {
      return '😊';
    }
  }

  String _getDescriptionEmoji(String description) {
    if (description.toLowerCase().contains('rain')) {
      return '🌧️';
    } else if (description.toLowerCase().contains('cloud')) {
      return '☁️';
    } else if (description.toLowerCase().contains('snow')) {
      return '❄️';
    } else {
      return '😊';
    }
  }

  String _getHumidityEmoji(int humidity) {
    if (humidity > 80) {
      return '💧';
    } else if (humidity < 30) {
      return '🏜️';
    } else {
      return '😊';
    }
  }

  String _getWindSpeedEmoji(double windSpeed) {
    if (windSpeed > 10) {
      return '🌬️';
    } else if (windSpeed < 2) {
      return '🍃';
    } else {
      return '😊';
    }
  }
}
