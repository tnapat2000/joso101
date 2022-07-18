import 'package:cloud_firestore/cloud_firestore.dart';

class Accident {
  final String email;
  final Timestamp accDate;
  final double lat;
  final double lng;
  final String expwStep;
  final int injured;
  final int death;
  final String cause;

  const Accident({
    required this.email,
    required this.accDate,
    required this.lat,
    required this.lng,
    required this.expwStep,
    required this.injured,
    required this.death,
    required this.cause,
  });
}
