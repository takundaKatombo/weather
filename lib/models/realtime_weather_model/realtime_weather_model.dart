import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'current.dart';
import 'location.dart';

class RealtimeWeatherModel extends Equatable {
  final Location? location;
  final Current? current;

  const RealtimeWeatherModel({this.location, this.current});

  factory RealtimeWeatherModel.fromMap(Map<String, dynamic> data) {
    return RealtimeWeatherModel(
      location: data['location'] == null
          ? null
          : Location.fromMap(data['location'] as Map<String, dynamic>),
      current: data['current'] == null
          ? null
          : Current.fromMap(data['current'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'location': location?.toMap(),
        'current': current?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RealtimeWeatherModel].
  factory RealtimeWeatherModel.fromJson(String data) {
    return RealtimeWeatherModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RealtimeWeatherModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RealtimeWeatherModel copyWith({
    Location? location,
    Current? current,
  }) {
    return RealtimeWeatherModel(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [location, current];
}
