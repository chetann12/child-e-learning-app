import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int highestScore = 0;
  int totalAttempts = 0;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    final scores = prefs.getStringList('quiz_scores') ?? [];
    final parsedScores = scores.map((e) => int.tryParse(e) ?? 0).toList();

    setState(() {
      highestScore = parsedScores.isNotEmpty
          ? parsedScores.reduce((a, b) => a > b ? a : b)
          : 0;
      totalAttempts = parsedScores.length;
    });
  }

  Future<void> _resetScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('quiz_scores');
    setState(() {
      highestScore = 0;
      totalAttempts = 0;
    });
  }

  void _confirmReset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reset Scores"),
        content: const Text("Are you sure you want to reset your scores?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              _resetScores();
              Navigator.pop(context);
            },
            child: const Text("Yes, Reset"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
                'assets/images/profile.jpeg'), // 👶 Add a cute profile image here!
          ),
          const SizedBox(height: 20),
          const Text(
            "Welcome, Little Star!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("Here's your learning progress ✨",
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
          _buildStatTile("🏆 Highest Quiz Score", "$highestScore / 10"),
          _buildStatTile("📊 Total Quiz Attempts", "$totalAttempts"),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _confirmReset,
            icon: const Icon(Icons.restart_alt),
            label: const Text("Reset My Score"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
