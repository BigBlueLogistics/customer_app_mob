import 'package:flutter/material.dart';

class MDBottomNavigationBar extends StatelessWidget {
  const MDBottomNavigationBar({
    super.key,
    required this.selectedBarIndex,
  });

  final int selectedBarIndex;

  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedBarIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.home_outlined,
            color: Colors.black54,
          ),
          label: 'Home',
          activeIcon:
              Icon(Icons.home_outlined, color: Theme.of(context).primaryColor),
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.inventory_rounded,
            color: Colors.black54,
          ),
          label: 'Inventory',
          activeIcon: Icon(Icons.inventory_rounded,
              color: Theme.of(context).primaryColor),
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.multiline_chart_rounded,
            color: Colors.black54,
          ),
          label: 'Movements',
          activeIcon: Icon(Icons.multiline_chart_rounded,
              color: Theme.of(context).primaryColor),
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.person_2_outlined,
            color: Colors.black54,
          ),
          label: 'Profile',
          activeIcon: Icon(Icons.person_2_outlined,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
