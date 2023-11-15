import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'forecastday.dart';

class Forecast extends Equatable {
  final List<Forecastday>? forecastday;

  const Forecast({this.forecastday});

  factory Forecast.fromMap(Map<String, dynamic> data) => Forecast(
        forecastday: (data['forecastday'] as List<dynamic>?)
            ?.map((e) => Forecastday.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'forecastday': forecastday?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Forecast].
  factory Forecast.fromJson(String data) {
    return Forecast.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Forecast] to a JSON string.
  String toJson() => json.encode(toMap());

  Forecast copyWith({
    List<Forecastday>? forecastday,
  }) {
    return Forecast(
      forecastday: forecastday ?? this.forecastday,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [forecastday];
}
