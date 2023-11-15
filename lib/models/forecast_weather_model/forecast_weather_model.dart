import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'current.dart';
import 'forecast.dart';
import 'location.dart';

class ForecastWeatherModel extends Equatable {
  final Location? location;
  final Current? current;
  final Forecast? forecast;

  const ForecastWeatherModel({this.location, this.current, this.forecast});

  factory ForecastWeatherModel.fromMap(Map<String, dynamic> data) {
    return ForecastWeatherModel(
      location: data['location'] == null
          ? null
          : Location.fromMap(data['location'] as Map<String, dynamic>),
      current: data['current'] == null
          ? null
          : Current.fromMap(data['current'] as Map<String, dynamic>),
      forecast: data['forecast'] == null
          ? null
          : Forecast.fromMap(data['forecast'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'location': location?.toMap(),
        'current': current?.toMap(),
        'forecast': forecast?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ForecastWeatherModel].
  factory ForecastWeatherModel.fromJson(String data) {
    return ForecastWeatherModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ForecastWeatherModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ForecastWeatherModel copyWith({
    Location? location,
    Current? current,
    Forecast? forecast,
  }) {
    return ForecastWeatherModel(
      location: location ?? this.location,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [location, current, forecast];
}
