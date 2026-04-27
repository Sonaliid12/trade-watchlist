import 'package:flutter/material.dart';

class WatchlistTabBar extends StatelessWidget {
  final List<String> watchlistNames;
  final String activeWatchlist;
  final Function(String) onTabSelected;
  final Function(String) onTabLongPressed;

  const WatchlistTabBar({
    super.key,
    required this.watchlistNames,
    required this.activeWatchlist,
    required this.onTabSelected,
    required this.onTabLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: watchlistNames.map((name) {
          final bool isActive = name == activeWatchlist;
          return GestureDetector(
            onTap: () => onTabSelected(name),
            onLongPress: () => onTabLongPressed(name),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isActive
                        ? const Color(0xFF1A1A1A)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? const Color(0xFF1A1A1A)
                      : const Color(0xFF9E9E9E),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}