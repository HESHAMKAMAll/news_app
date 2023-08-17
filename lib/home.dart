import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:news/wall_street_journal.dart';
import 'egypt_news.dart';

var gradient = const LinearGradient(
  colors: [
    Color.fromRGBO(187, 63, 221, 1),
    Color.fromRGBO(251, 109, 169, 1),
    Color.fromRGBO(255, 159, 124, 1),
  ],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  List<Widget> widgetPages = [
    const PageOne(),
    const PageTwo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetPages.elementAt(selected),
      bottomNavigationBar: BottomBarBubble(
        backgroundColor: const Color(0xFF27222B),
        color: Colors.pinkAccent,
        selectedIndex: selected,
        items: [
          BottomBarItem(iconData: Icons.home, label: "Wall Street Journal"),
          BottomBarItem(iconData: Icons.chat, label: "Egypt News"),
          // BottomBarItem(iconData: Icons.notifications),
          // BottomBarItem(iconData: Icons.calendar_month),
          // BottomBarItem(iconData: Icons.settings),
        ],
        onSelect: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
