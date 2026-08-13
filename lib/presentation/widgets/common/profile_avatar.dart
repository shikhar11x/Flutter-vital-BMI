import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Profile avatar widget
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double size;
  final VoidCallback? onTap;
  final bool showEditIcon;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = 80,
    this.onTap,
    this.showEditIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Avatar circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.8),
                  AppColors.primary.withValues(alpha: 0.4),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: imageUrl != null
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildInitialsView();
                      },
                    ),
                  )
                : _buildInitialsView(),
          ),

          // Edit icon
          if (showEditIcon)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.35,
                height: size * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  border: Border.all(
                    color: AppColors.cardBg,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInitialsView() {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Small avatar (for lists)
class SmallProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  final double size;

  const SmallProfileAvatar({
    super.key,
    this.imageUrl,
    required this.initials,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileAvatar(
      imageUrl: imageUrl,
      initials: initials,
      size: size,
    );
  }
}