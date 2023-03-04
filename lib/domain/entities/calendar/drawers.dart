import 'dart:math';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WeekDrawer {
  WeekDrawer(this.lines);

  List<EventsLineDrawer> lines;
}

class EventsLineDrawer {
  List<EventProperties> events = [];
}

class EventProperties extends Equatable {
  const EventProperties({
    required this.begin,
    required this.end,
    required this.name,
    required this.backgroundColor,
  });

  final int begin;
  final int end;
  final Color backgroundColor;

  final String name;

  int size() => end - begin + 1;

  @override
  List<Object?> get props => [begin, end, name, backgroundColor];

  @override
  bool get stringify => true;
}
