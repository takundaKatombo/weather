import 'dart:convert';

import 'package:equatable/equatable.dart';

class Condition extends Equatable {
  final String? text;
  final String? icon;
  final int? code;

  const Condition({this.text, this.icon, this.code});

  factory Condition.fromMap(Map<String, dynamic> data) => Condition(
        text: data['text'] as String?,
        icon: data['icon'] as String?,
        code: data['code'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'text': text,
        'icon': icon,
        'code': code,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Condition].
  factory Condition.fromJson(String data) {
    return Condition.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Condition] to a JSON string.
  String toJson() => json.encode(toMap());

  Condition copyWith({
    String? text,
    String? icon,
    int? code,
  }) {
    return Condition(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      code: code ?? this.code,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [text, icon, code];
}
