import 'package:flutter/material.dart';
import '../theme/colors.dart';

class PracticeTab extends StatelessWidget {
  const PracticeTab({super.key});

  final List<String> letters = const [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  final List<String> numbers = const [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Alphabets"),
              Tab(text: "Numbers"),
            ],
            labelColor: AppColors.accent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.accent,
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildGrid(context, letters, isLetter: true),
                _buildGrid(context, numbers, isLetter: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<String> items,
      {required bool isLetter}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          String item = items[index];
          String imagePath = 'assets/images/${item.toLowerCase()}.png';

          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You tapped on '$item'"),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(imagePath, fit: BoxFit.contain),
                    ),
                  ),
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
