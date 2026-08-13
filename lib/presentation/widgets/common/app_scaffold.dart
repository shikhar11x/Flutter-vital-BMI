import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Custom scaffold widget
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool safeArea;

  const AppScaffold({
    Key? key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.onBackPressed,
    this.showBackButton = true,
    this.actions,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.safeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.darkBg,
      appBar: title != null || showBackButton || (actions?.isNotEmpty ?? false)
          ? AppBar(
              title: title != null
                  ? Text(
                      title!,
                      style: AppTextStyles.heading3,
                    )
                  : null,
              centerTitle: false,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: onBackPressed ?? () => Navigator.pop(context),
                    )
                  : null,
              actions: actions,
            )
          : null,
      body: safeArea
          ? SafeArea(
              child: body,
            )
          : body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}