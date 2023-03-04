// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final int? id;
  final String title;
  final String description;
  final DateTime begin;
  final DateTime end;
  final DateTime created;
  final bool isCompleted;
  final int level;
  const Schedule({
    this.id,
    required this.title,
    required this.description,
    required this.begin,
    required this.end,
    required this.created,
    required this.isCompleted,
    required this.level,
  });

  @override
  List<Object> get props {
    return [
      id ?? 0,
      title,
      description,
      begin,
      end,
      created,
      isCompleted,
      level,
    ];
  }
}
