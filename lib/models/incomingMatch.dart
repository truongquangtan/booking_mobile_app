import 'package:flutter/material.dart';

class IncomingMatch {
  final String bookingId;
  final String startTime;
  final String endTime;
  final String date;
  final String yardName;
  final String yardAddress;
  final String subYardName;
  final String subYardType;
  final String bookAt;

  IncomingMatch(this.bookingId, this.startTime, this.endTime, this.date, this.yardName, this.yardAddress, this.subYardName, this.subYardType, this.bookAt);

  factory IncomingMatch.fromJson(Map<String, dynamic> json) {
    return IncomingMatch(
      json['bookingId'], 
      json['startTime'], 
      json['endTime'], 
      json['date'], 
      json['bigYardName'],
      json['bigYardAddress'],
      json['subYardName'],
      json['type'],
      json['bookAt'],
    );
  }
}