import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Custom bottom navigation bar
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: item.icon,
                activeIcon: item.activeIcon ?? item.icon,
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Bottom navigation item
class BottomNavItem {
  final Widget icon;
  final Widget? activeIcon;
  final String label;

  BottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}