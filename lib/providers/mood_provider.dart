// lib/providers/mood_provider.dart
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodProvider with ChangeNotifier {
  final List<MoodEntry> _moodHistory = [];

  List<MoodEntry> get moodHistory => _moodHistory;

  // Daftar mood yang tersedia di aplikasi
  final List<Mood> availableMoods = [
    Mood(
      name: 'Senang',
      icon: Icons.sentiment_very_satisfied,
      color: Colors.green,
    ),
    Mood(name: 'Biasa', icon: Icons.sentiment_satisfied, color: Colors.blue),
    Mood(name: 'Sedih', icon: Icons.sentiment_dissatisfied, color: Colors.grey),
    Mood(
      name: 'Marah',
      icon: Icons.sentiment_very_dissatisfied,
      color: Colors.red,
    ),
    Mood(name: 'Keren', icon: Icons.star, color: Colors.amber),
  ];

  void addMood(Mood mood) {
    // Menghapus entri hari ini jika sudah ada, agar bisa diganti
    _moodHistory.removeWhere(
      (entry) => DateUtils.isSameDay(entry.date, DateTime.now()),
    );

    final newEntry = MoodEntry(mood: mood, date: DateTime.now());
    _moodHistory.insert(0, newEntry); // Tambahkan di awal list
    notifyListeners();
  }
}
