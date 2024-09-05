import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:elearning/services/router_service.dart';
import 'package:elearning/extensions/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elearning',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildNavButton(
              onPressed: () => NavigationManager.router.go('/home/courses'),
              label: context.l10n!.courses,
              icon: const Icon(FluentIcons.book_28_regular),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required VoidCallback onPressed,
    required String label,
    required Icon icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FilledButton.icon(
        onPressed: onPressed,
        label: Text(label),
        icon: icon,
      ),
    );
  }
}
