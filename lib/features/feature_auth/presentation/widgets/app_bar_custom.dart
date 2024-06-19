import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashgh/core/utils/color_manager.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    this.iconButton,
  });

  final IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: iconButton,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.seeBlue.withOpacity(0.1),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: ColorManager.darkpurple.withOpacity(0.3),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
        systemStatusBarContrastEnforced: true,
      ),
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.3),
              ColorManager.white,
            ],
            stops: const [
              0.0,
              1.0,
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}
