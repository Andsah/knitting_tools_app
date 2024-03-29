import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../models/rive_asset.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.menu,
    required this.onPress,
    required this.riveonInit,
    required this.isActive,
  });

  final RiveAsset menu;
  final VoidCallback onPress;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, right: 20),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              height: 56,
              left: 0,
              width: isActive ? 268 : 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            ListTile(
              onTap: onPress,
              leading: SizedBox(
                  width: 34,
                  height: 34,
                  child: RiveAnimation.asset(
                    menu.src,
                    artboard: menu.artboard,
                    onInit: riveonInit,
                  )),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
