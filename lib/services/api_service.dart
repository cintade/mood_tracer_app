import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mood.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Mood>> getMoods() async {
    final res = await http.get(Uri.parse('$baseUrl/moods'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Mood.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load moods');
    }
  }

  Future<void> postMood(Mood mood) async {
    await http.post(
      Uri.parse('$baseUrl/moods'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mood.toJson()),
    );
  }
}
