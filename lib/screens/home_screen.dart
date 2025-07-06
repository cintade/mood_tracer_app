// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/mood_entry.dart';
import '../providers/mood_provider.dart';
import '../widgets/mood_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Mood? _selectedMood;

  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context, listen: false);
    final availableMoods = moodProvider.availableMoods;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.go('/history'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bagaimana perasaanmu hari ini?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // UI Responsif dengan GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Selalu 2 kolom untuk kesederhanaan
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: availableMoods.length,
                itemBuilder: (context, index) {
                  final mood = availableMoods[index];
                  return MoodCard(
                    mood: mood,
                    isSelected: _selectedMood?.name == mood.name,
                    onTap: () {
                      setState(() {
                        _selectedMood = mood;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: _selectedMood == null
                  ? null
                  : () {
                      moodProvider.addMood(_selectedMood!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Mood "${_selectedMood!.name}" telah disimpan!',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context.go('/history');
                    },
              child: const Text('Simpan Mood'),
            ),
          ],
        ),
      ),
    );
  }
}
