// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AccidentModels accModelsFromJson(String str) =>
    AccidentModels.fromJson(json.decode(str));

String accModelsToJson(AccidentModels data) => json.encode(data.toJson());

class AccidentModels {
  AccidentModels({
    required this.resultCode,
    required this.result,
  });

  final int resultCode;
  final List<AccidentMod> result;

  factory AccidentModels.fromJson(Map<String, dynamic> json) => AccidentModels(
        resultCode: json["resultCode"],
        result: List<AccidentMod>.from(
            json["result"].map((x) => AccidentMod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class AccidentMod {
  AccidentMod({
    required this.id,
    required this.accidentDate,
    required this.accidentTime,
    required this.expwStep,
    required this.weatherState,
    required this.injurMan,
    required this.injurFemel,
    required this.deadMan,
    required this.deadFemel,
    required this.cause,
  });

  final int id;
  final DateTime accidentDate;
  final String accidentTime;
  final String expwStep;
  final WeatherState weatherState;
  final int injurMan;
  final int injurFemel;
  final int deadMan;
  final int deadFemel;
  final String cause;

  factory AccidentMod.fromJson(Map<String, dynamic> json) => AccidentMod(
        id: json["_id"],
        accidentDate: DateTime.parse(json["accident_date"]),
        accidentTime: json["accident_time"],
        expwStep: json["expw_step"],
        weatherState:
            weatherStateValues.map[json["weather_state"]] ?? WeatherState.EMPTY,
        injurMan: json["injur_man"],
        injurFemel: json["injur_femel"],
        deadMan: json["dead_man"],
        deadFemel: json["dead_femel"],
        cause: json["cause"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "accident_date":
            "${accidentDate.year.toString().padLeft(4, '0')}-${accidentDate.month.toString().padLeft(2, '0')}-${accidentDate.day.toString().padLeft(2, '0')}",
        "accident_time": accidentTime,
        "expw_step": expwStep,
        "weather_state": weatherStateValues.reverse[weatherState],
        "injur_man": injurMan,
        "injur_femel": injurFemel,
        "dead_man": deadMan,
        "dead_femel": deadFemel,
        "cause": cause,
      };
}

enum WeatherState { EMPTY, WEATHER_STATE }

final weatherStateValues = EnumValues(
    {"ปกติ": WeatherState.EMPTY, "ฝนตก": WeatherState.WEATHER_STATE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}

enum Express {
  SRI_RACH,
  BANG_PLI_SUK_SAWAT,
  CHALONG_RACH,
  BURAPHA,
  UDORN,
  CHALEOM,
  THE_37,
  S1,
  OUTSIDE_SRI_RACH
}

final ExpressStrVal = EnumValues({
  "ศรีรัช": Express.SRI_RACH,
  "บางพลี-สุขสวัสดิ์": Express.BANG_PLI_SUK_SAWAT,
  "ฉลองรัช": Express.CHALONG_RACH,
  "บูรพาวิถี": Express.BURAPHA,
  "S1": Express.S1,
  "อุดรรัถยา": Express.UDORN,
  "เฉลิมมหานคร": Express.CHALEOM,
  "ทางหลวงพิเศษหมายเลข 37": Express.THE_37,
  "ศรีรัช-วงแหวนรอบนอก": Express.OUTSIDE_SRI_RACH
});

