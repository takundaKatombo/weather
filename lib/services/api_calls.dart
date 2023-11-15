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
  } catch (e) {
    // if (e.response != null) {
    //   print('Dio error!');
    //   print('STATUS: ${e.response?.statusCode}');
    //   print('DATA: ${e.response?.data}');
    //   print('HEADERS: ${e.response?.headers}');
    // } else {
    //   // Error due to setting up or sending the request
    //   print('Error sending request!');
    //   print(e.message);
    // }
  }
}

Future<ForecastWeatherModel> getForecastData({required String location}) async {
  // try {
  print('just in try ');
  var url =
      Uri.https(urlAddress, "/forecast.json", {'q': location, 'days': '5'});
  var response = await http.get(url, headers: {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': "weatherapi-com.p.rapidapi.com"
  });
  print('just after get request');

  // var responseList = jsonDecode(response.body);
  // print('just after decoding $responseList ');
  // print('response List length ${responseList.length}');
  late ForecastWeatherModel retVal;
  // try {
  //   print('just in try 2');
  retVal = ForecastWeatherModel.fromJson(response.body);
  // } catch (e) {
  //   print("try 2 catch block error: $e");
  //   throw e;
  // }

  print("ret vat: $retVal");
  print(retVal.forecast!.forecastday!.length);
  return retVal;
  // } catch (e) {
  // if (e.response != null) {
  //   print('Dio error!');
  //   print('STATUS: ${e.response?.statusCode}');
  //   print('DATA: ${e.response?.data}');
  //   print('HEADERS: ${e.response?.headers}');
  // } else {
  //   // Error due to setting up or sending the request
  //   print('Error sending request!');
  // print(e);
  // }
  // }
  // return Future.value(ForecastWeatherModel());
}
