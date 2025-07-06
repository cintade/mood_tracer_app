// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:mood_tracer_app/providers/mood_provider.dart';
import 'package:mood_tracer_app/widgets/mood_list_item.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Inisialisasi data lokal untuk format tanggal Indonesia
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Mood')),
      body: Consumer<MoodProvider>(
        builder: (context, moodProvider, child) {
          if (moodProvider.moodHistory.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada riwayat mood.\nAyo catat perasaanmu!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: moodProvider.moodHistory.length,
            itemBuilder: (context, index) {
              final entry = moodProvider.moodHistory[index];
              return MoodListItem(entry: entry);
            },
          );
        },
      ),
    );
  }
}
