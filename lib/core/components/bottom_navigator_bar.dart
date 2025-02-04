import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<Widget> screens;

  const CustomBottomNavigationBar({
    super.key,
    required this.screens,
  });

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_outlined,
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box_outlined,
            ),
            label: 'Done',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
