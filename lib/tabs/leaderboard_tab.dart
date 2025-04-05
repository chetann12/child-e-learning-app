import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderBoardTab extends StatefulWidget {
  const LeaderBoardTab({super.key});

  @override
  State<LeaderBoardTab> createState() => _LeaderBoardTabState();
}

class _LeaderBoardTabState extends State<LeaderBoardTab> {
  List<String> scores = [];

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  void _loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      scores = prefs.getStringList('quiz_scores')?.reversed.toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return scores.isEmpty
        ? const Center(child: Text('No scores yet. Play a quiz!'))
        : ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('#${index + 1}')),
                title: Text('Score: ${scores[index]} / 10'),
              );
            },
          );
  }
}
