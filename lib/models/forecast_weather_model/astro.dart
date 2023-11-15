import 'dart:convert';

import 'package:equatable/equatable.dart';

class Astro extends Equatable {
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moonPhase;
  final int? moonIllumination;
  final int? isMoonUp;
  final int? isSunUp;

  const Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory Astro.fromMap(Map<String, dynamic> data) => Astro(
        sunrise: data['sunrise'] as String?,
        sunset: data['sunset'] as String?,
        moonrise: data['moonrise'] as String?,
        moonset: data['moonset'] as String?,
        moonPhase: data['moon_phase'] as String?,
        moonIllumination: data['moon_illumination'] as int?,
        isMoonUp: data['is_moon_up'] as int?,
        isSunUp: data['is_sun_up'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'sunrise': sunrise,
        'sunset': sunset,
        'moonrise': moonrise,
        'moonset': moonset,
        'moon_phase': moonPhase,
        'moon_illumination': moonIllumination,
        'is_moon_up': isMoonUp,
        'is_sun_up': isSunUp,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Astro].
  factory Astro.fromJson(String data) {
    return Astro.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Astro] to a JSON string.
  String toJson() => json.encode(toMap());

  Astro copyWith({
    String? sunrise,
    String? sunset,
    String? moonrise,
    String? moonset,
    String? moonPhase,
    int? moonIllumination,
    int? isMoonUp,
    int? isSunUp,
  }) {
    return Astro(
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonrise: moonrise ?? this.moonrise,
      moonset: moonset ?? this.moonset,
      moonPhase: moonPhase ?? this.moonPhase,
      moonIllumination: moonIllumination ?? this.moonIllumination,
      isMoonUp: isMoonUp ?? this.isMoonUp,
      isSunUp: isSunUp ?? this.isSunUp,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sunrise,
      sunset,
      moonrise,
      moonset,
      moonPhase,
      moonIllumination,
      isMoonUp,
      isSunUp,
    ];
  }
}
