// lib/models/mood_entry.dart
import 'package:flutter/material.dart';

class Mood {
  final String name;
  final IconData icon;
  final Color color;

  Mood({required this.name, required this.icon, required this.color});
}

class MoodEntry {
  final Mood mood;
  final DateTime date;
  final String? note;

  MoodEntry({required this.mood, required this.date, this.note});
}
