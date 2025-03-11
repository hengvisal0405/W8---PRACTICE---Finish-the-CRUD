import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_controller.dart'; // Direct import instead of provider.dart

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorCounter(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    ),
  );
}

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('Build Home widget');
    return Scaffold(
      body: _currentIndex == 0
          ? const ColorTapsScreen()
          : const StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building ColorTapsScreen widget');
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Column(
        children: const [
          ColorTap(type: CardType.red),
          ColorTap(type: CardType.blue),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({
    super.key,
    required this.type,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    print(
        'Building ColorTap widget (${type == CardType.red ? 'red' : 'blue'})');

    return Consumer<ColorCounter>(
      builder: (context, colorCounter, child) {
        final tapCount = type == CardType.red
            ? colorCounter.redTapCount
            : colorCounter.blueTapCount;

        print(
            'Consumer rebuilding for ${type == CardType.red ? 'red' : 'blue'} tap with count: $tapCount');

        return GestureDetector(
          onTap: () {
            if (type == CardType.red) {
              colorCounter.incrementRedTapCount();
            } else {
              colorCounter.incrementBlueTapCount();
            }
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $tapCount',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building StatisticsScreen widget');

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Consumer<ColorCounter>(
          builder: (context, colorCounter, child) {
            print(
                'Consumer rebuilding for statistics with red: ${colorCounter.redTapCount}, blue: ${colorCounter.blueTapCount}');

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${colorCounter.redTapCount}',
                    style: const TextStyle(fontSize: 24)),
                Text('Blue Taps: ${colorCounter.blueTapCount}',
                    style: const TextStyle(fontSize: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}
