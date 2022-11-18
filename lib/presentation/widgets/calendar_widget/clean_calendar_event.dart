import 'package:flutter/material.dart';

class CleanCalendarEvent {
  String summary;
  String description;
  String location;
  DateTime startTime;
  DateTime endTime;
  String type;
  Color color;
  bool isAllDay;
  bool isDone;
  CleanCalendarEvent(
    this.summary,
    this.type, {
    this.description = '',
    this.location = '',
    required this.startTime,
    required this.endTime,
    this.isAllDay = false,
    this.isDone = false,
    required Color color,
  }) : color = type == 'Lain'
            ? const Color.fromARGB(255, 141, 153, 174)
            : type == 'Rapat'
                ? const Color.fromARGB(255, 237, 29, 36)
                : type == 'Jaga Lab'
                    ? const Color.fromARGB(255, 216, 2, 100)
                    : type == 'Workshop'
                        ? const Color.fromARGB(255, 165, 55, 139)
                        : type == 'Jamming'
                            ? const Color.fromARGB(255, 102, 76, 145)
                            : type == 'Praktikum'
                                ? const Color.fromARGB(255, 53, 79, 124)
                                : type == 'Mudah'
                                    ? const Color.fromARGB(255, 47, 72, 88)
                                    : const Color.fromARGB(255, 141, 153, 174);
}
