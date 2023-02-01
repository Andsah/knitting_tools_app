import "dart:ui";

import "package:flutter/material.dart";
import "package:rive/rive.dart";
import "../utils/rive_utils.dart";
import "info_card.dart";
import "side_menu_tile.dart";
import "../models/rive_asset.dart";

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.callback});

  final Function callback;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          width: 288,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black54,
          ),
          padding:
              const EdgeInsets.only(top: 26, bottom: 26, right: 10, left: 10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Column(children: [
              InfoCard(name: "Andreas Sahlin", craft: "Knitter & crocheter"),
              ...sideMenus.map((menu) => SideMenuTile(
                  menu: menu,
                  onPress: () {
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                    widget.callback(menu.title);
                  },
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active");
                  },
                  isActive: selectedMenu == menu))
            ]),
          )),
    );
  }
}
