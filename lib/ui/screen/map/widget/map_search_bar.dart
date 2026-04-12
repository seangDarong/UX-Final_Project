import 'package:flutter/material.dart';

/// A read-only search bar that sits over the map.
class MapSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const MapSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.search, color: Colors.grey, size: 20),
            const SizedBox(width: 10),
            Text(
              'Search stations',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
