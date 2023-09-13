import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherController extends GetxController {
  final apiKey = '310a423220bfa094fa77cc7beb6d45e4';
  var weatherData = {}.obs;
  var errorMessage = ''.obs;

  void fetchWeather(String city) async {
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      weatherData.value = data;
      errorMessage.value = '';
    } else {
      weatherData.value = {};
      errorMessage.value = 'City not found';
      print('Error fetching weather data');
    }
  }
}
