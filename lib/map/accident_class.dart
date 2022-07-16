import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Accident {
  final String email;
  final Timestamp acc_date;
  final double lat;
  final double lng;
  final String expw_step;
  final int injured;
  final int death;
  final String cause;

  const Accident({
    required this.email,
    required this.acc_date,
    required this.lat,
    required this.lng,
    required this.expw_step,
    required this.injured,
    required this.death,
    required this.cause,
  });
}
