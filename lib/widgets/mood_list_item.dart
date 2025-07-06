// lib/widgets/mood_list_item.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/mood_entry.dart';

class MoodListItem extends StatelessWidget {
  final MoodEntry entry;

  const MoodListItem({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(entry.mood.icon, color: entry.mood.color, size: 40),
        title: Text(
          entry.mood.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(entry.date),
        ),
      ),
    );
  }
}
