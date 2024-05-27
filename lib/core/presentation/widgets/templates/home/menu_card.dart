import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menuList,
    required this.index,
  });

  final List<Map<String, dynamic>> menuList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: menuList[index]['icon'],
              ),
              const SizedBox(height: 8.0),
              Text(
                '${menuList[index]['title']}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ]),
            const Text(
              'Tap to View',
              style: TextStyle(color: Colors.white70, fontSize: 13.0),
            )
          ],
        ),
      ),
    );
  }
}
