import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/forecast_weather_model/forecast_weather_model.dart';
import 'package:weather/models/realtime_weather_model/realtime_weather_model.dart';
import 'package:weather/private.dart';

Future getRealtimeData({required String location}) async {
  try {
    var url =
        Uri.https(urlAddress, Uri(queryParameters: {'q': location}).query);
    var response = await http.get(url, headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': "weatherapi-com.p.rapidapi.com"
    });
    List<dynamic> responseList = jsonDecode(response.body);
    List<RealtimeWeatherModel> retVal =
        responseList.map((n) => RealtimeWeatherModel.fromJson(n)).toList();
    return retVal;
  } catch (e) {}
}

Future<ForecastWeatherModel> getForecastData({required String location}) async {
  // try {
  var url =
      Uri.https(urlAddress, "/forecast.json", {'q': location, 'days': '3'});
  var response = await http.get(url, headers: {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': "weatherapi-com.p.rapidapi.com"
  });

  late ForecastWeatherModel retVal;

  retVal = ForecastWeatherModel.fromJson(response.body);

  return retVal;
}
