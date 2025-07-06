import 'package:flutter/material.dart';
import '../models/mood.dart';
import '../services/api_service.dart';

class MoodListScreen extends StatefulWidget {
  @override
  _MoodListScreenState createState() => _MoodListScreenState();
}

class _MoodListScreenState extends State<MoodListScreen> {
  final api = ApiService();
  late Future<List<Mood>> _futureMoods;

  @override
  void initState() {
    super.initState();
    _futureMoods = api.getMoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Mood')),
      body: FutureBuilder<List<Mood>>(
        future: _futureMoods,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          final moods = snapshot.data!;
          return ListView.builder(
            itemCount: moods.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.mood),
                title: Text(moods[index].mood),
                subtitle: Text(moods[index].note),
              );
            },
          );
        },
      ),
    );
  }
}
