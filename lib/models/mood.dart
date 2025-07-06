class Mood {
  final String id;
  final String mood;
  final String note;

  Mood({
    required this.id,
    required this.mood,
    required this.note,
  });

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      id: json['_id'] ?? '',
      mood: json['mood'] ?? '',
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'note': note,
    };
  }
}
