import 'dart:convert';

List<AccidentModel> accidentModelFromJson(String str) =>
    List<AccidentModel>.from(
        json.decode(str).map((x) => AccidentModel.fromJson(x)));

String accidentModelToJson(List<AccidentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccidentModel {
  AccidentModel({
    required this.id,
    required this.accidentDate,
    required this.accidentTime,
    required this.expwStep,
    required this.weatherState,
    required this.injuredMan,
    required this.injuredFemale,
    required this.deadMan,
    required this.deadFemale,
    required this.cause,
  });

  final int id;
  final DateTime accidentDate;
  final String accidentTime;
  final String expwStep;
  final WeatherState weatherState;
  final int injuredMan;
  final int injuredFemale;
  final int deadMan;
  final int deadFemale;
  final String cause;

  factory AccidentModel.fromJson(Map<String, dynamic> json) => AccidentModel(
        id: json["_id"],
        accidentDate: DateTime.parse(json["accident_date"]),
        accidentTime: json["accident_time"],
        expwStep: json["expw_step"],
        weatherState: weatherStateValues.map[json["weather_state"]]!,
        injuredMan: json["injured_man"],
        injuredFemale: json["injured_female"],
        deadMan: json["dead_man"],
        deadFemale: json["dead_female"],
        cause: json["cause"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "accident_date":
            "${accidentDate.year.toString().padLeft(4, '0')}-${accidentDate.month.toString().padLeft(2, '0')}-${accidentDate.day.toString().padLeft(2, '0')}",
        "accident_time": accidentTime,
        "expw_step": expwStep,
        "weather_state": weatherStateValues.reverse[weatherState],
        "injured_man": injuredMan,
        "injured_female": injuredFemale,
        "dead_man": deadMan,
        "dead_female": deadFemale,
        "cause": cause,
      };
}

enum WeatherState { EMPTY, WEATHER_STATE }

final weatherStateValues = EnumValues(
    {"ปกติ": WeatherState.EMPTY, "ฝนตก": WeatherState.WEATHER_STATE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // reverseMap;
    return reverseMap;
  }
}
