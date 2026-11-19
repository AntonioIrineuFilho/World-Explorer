import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_icons.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});
  @override Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false, titleSpacing: 20,
    title: Row(children: [Image.asset(AppIcons.globe, width: 40, height: 40), const SizedBox(width: 12), const Flexible(child: Text('World Explorer', overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w800, fontSize: 20)))]),
    actions: [Builder(builder: (context) => IconButton(tooltip: 'Abrir menu', icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openEndDrawer()))],
  );
  @override Size get preferredSize => const Size.fromHeight(64);
}
