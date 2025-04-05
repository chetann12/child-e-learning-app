
import 'package:flutter/material.dart';
import 'tabs/practice_tab.dart';
import 'tabs/quiz_tab.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/profile_tab.dart';
import 'theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kids Learning'),
          backgroundColor: AppColors.secondary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Practice'),
              Tab(text: 'Quiz'),
              Tab(text: 'Leaderboard'),
              Tab(text: 'Profile'),
            ],
            indicatorColor: AppColors.accent,
            labelColor: AppColors.accent,
            unselectedLabelColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            PracticeTab(),
            QuizTab(),
            LeaderBoardTab(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}
