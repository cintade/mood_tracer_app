// lib/widgets/mood_card.dart
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodCard extends StatelessWidget {
  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodCard({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Animasi Implisit dengan AnimatedContainer
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color:
            isSelected
                ? mood.color.withOpacity(0.3)
                : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? mood.color : Colors.transparent,
          width: 2,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: mood.color.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
                : [],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(mood.icon, size: 48, color: mood.color),
              const SizedBox(height: 8),
              Text(mood.name, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
