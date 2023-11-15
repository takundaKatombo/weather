import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'astro.dart';
import 'day.dart';
import 'hour.dart';

class Forecastday extends Equatable {
  final String? date;
  final int? dateEpoch;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  const Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory Forecastday.fromMap(Map<String, dynamic> data) => Forecastday(
        date: data['date'] as String?,
        dateEpoch: data['date_epoch'] as int?,
        day: data['day'] == null
            ? null
            : Day.fromMap(data['day'] as Map<String, dynamic>),
        astro: data['astro'] == null
            ? null
            : Astro.fromMap(data['astro'] as Map<String, dynamic>),
        hour: (data['hour'] as List<dynamic>?)
            ?.map((e) => Hour.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'date': date,
        'date_epoch': dateEpoch,
        'day': day?.toMap(),
        'astro': astro?.toMap(),
        'hour': hour?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Forecastday].
  factory Forecastday.fromJson(String data) {
    return Forecastday.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Forecastday] to a JSON string.
  String toJson() => json.encode(toMap());

  Forecastday copyWith({
    String? date,
    int? dateEpoch,
    Day? day,
    Astro? astro,
    List<Hour>? hour,
  }) {
    return Forecastday(
      date: date ?? this.date,
      dateEpoch: dateEpoch ?? this.dateEpoch,
      day: day ?? this.day,
      astro: astro ?? this.astro,
      hour: hour ?? this.hour,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [date, dateEpoch, day, astro, hour];
}
