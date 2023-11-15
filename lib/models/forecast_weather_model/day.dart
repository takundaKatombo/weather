import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'condition.dart';

class Day extends Equatable {
  final double? maxtempC;
  final double? maxtempF;
  final double? mintempC;
  final double? mintempF;
  final double? avgtempC;
  final double? avgtempF;
  final double? maxwindMph;
  final double? maxwindKph;
  final double? totalprecipMm;
  final double? totalprecipIn;
  final double? totalsnowCm;
  final double? avgvisKm;
  final double? avgvisMiles;
  final double? avghumidity;
  final int? dailyWillItRain;
  final int? dailyChanceOfRain;
  final int? dailyWillItSnow;
  final int? dailyChanceOfSnow;
  final Condition? condition;
  final double? uv;

  const Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  factory Day.fromMap(Map<String, dynamic> data) => Day(
        maxtempC: (data['maxtemp_c'] as num?)?.toDouble(),
        maxtempF: (data['maxtemp_f'] as num?)?.toDouble(),
        mintempC: (data['mintemp_c'] as num?)?.toDouble(),
        mintempF: (data['mintemp_f'] as num?)?.toDouble(),
        avgtempC: (data['avgtemp_c'] as num?)?.toDouble(),
        avgtempF: (data['avgtemp_f'] as num?)?.toDouble(),
        maxwindMph: (data['maxwind_mph'] as num?)?.toDouble(),
        maxwindKph: (data['maxwind_kph'] as num?)?.toDouble(),
        totalprecipMm: (data['totalprecip_mm'] as num?)?.toDouble(),
        totalprecipIn: (data['totalprecip_in'] as num?)?.toDouble(),
        totalsnowCm: data['totalsnow_cm'] as double?,
        avgvisKm: data['avgvis_km'] as double?,
        avgvisMiles: data['avgvis_miles'] as double?,
        avghumidity: data['avghumidity'] as double?,
        dailyWillItRain: data['daily_will_it_rain'] as int?,
        dailyChanceOfRain: data['daily_chance_of_rain'] as int?,
        dailyWillItSnow: data['daily_will_it_snow'] as int?,
        dailyChanceOfSnow: data['daily_chance_of_snow'] as int?,
        condition: data['condition'] == null
            ? null
            : Condition.fromMap(data['condition'] as Map<String, dynamic>),
        uv: data['uv'] as double?,
      );

  Map<String, dynamic> toMap() => {
        'maxtemp_c': maxtempC,
        'maxtemp_f': maxtempF,
        'mintemp_c': mintempC,
        'mintemp_f': mintempF,
        'avgtemp_c': avgtempC,
        'avgtemp_f': avgtempF,
        'maxwind_mph': maxwindMph,
        'maxwind_kph': maxwindKph,
        'totalprecip_mm': totalprecipMm,
        'totalprecip_in': totalprecipIn,
        'totalsnow_cm': totalsnowCm,
        'avgvis_km': avgvisKm,
        'avgvis_miles': avgvisMiles,
        'avghumidity': avghumidity,
        'daily_will_it_rain': dailyWillItRain,
        'daily_chance_of_rain': dailyChanceOfRain,
        'daily_will_it_snow': dailyWillItSnow,
        'daily_chance_of_snow': dailyChanceOfSnow,
        'condition': condition?.toMap(),
        'uv': uv,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Day].
  factory Day.fromJson(String data) {
    return Day.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Day] to a JSON string.
  String toJson() => json.encode(toMap());

  Day copyWith({
    double? maxtempC,
    double? maxtempF,
    double? mintempC,
    double? mintempF,
    double? avgtempC,
    double? avgtempF,
    double? maxwindMph,
    double? maxwindKph,
    double? totalprecipMm,
    double? totalprecipIn,
    double? totalsnowCm,
    double? avgvisKm,
    double? avgvisMiles,
    double? avghumidity,
    int? dailyWillItRain,
    int? dailyChanceOfRain,
    int? dailyWillItSnow,
    int? dailyChanceOfSnow,
    Condition? condition,
    double? uv,
  }) {
    return Day(
      maxtempC: maxtempC ?? this.maxtempC,
      maxtempF: maxtempF ?? this.maxtempF,
      mintempC: mintempC ?? this.mintempC,
      mintempF: mintempF ?? this.mintempF,
      avgtempC: avgtempC ?? this.avgtempC,
      avgtempF: avgtempF ?? this.avgtempF,
      maxwindMph: maxwindMph ?? this.maxwindMph,
      maxwindKph: maxwindKph ?? this.maxwindKph,
      totalprecipMm: totalprecipMm ?? this.totalprecipMm,
      totalprecipIn: totalprecipIn ?? this.totalprecipIn,
      totalsnowCm: totalsnowCm ?? this.totalsnowCm,
      avgvisKm: avgvisKm ?? this.avgvisKm,
      avgvisMiles: avgvisMiles ?? this.avgvisMiles,
      avghumidity: avghumidity ?? this.avghumidity,
      dailyWillItRain: dailyWillItRain ?? this.dailyWillItRain,
      dailyChanceOfRain: dailyChanceOfRain ?? this.dailyChanceOfRain,
      dailyWillItSnow: dailyWillItSnow ?? this.dailyWillItSnow,
      dailyChanceOfSnow: dailyChanceOfSnow ?? this.dailyChanceOfSnow,
      condition: condition ?? this.condition,
      uv: uv ?? this.uv,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      maxtempC,
      maxtempF,
      mintempC,
      mintempF,
      avgtempC,
      avgtempF,
      maxwindMph,
      maxwindKph,
      totalprecipMm,
      totalprecipIn,
      totalsnowCm,
      avgvisKm,
      avgvisMiles,
      avghumidity,
      dailyWillItRain,
      dailyChanceOfRain,
      dailyWillItSnow,
      dailyChanceOfSnow,
      condition,
      uv,
    ];
  }
}
