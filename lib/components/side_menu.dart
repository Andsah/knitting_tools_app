import "package:flutter/material.dart";
import "package:rive/rive.dart";
import "../utils/rive_utils.dart";
import "info_card.dart";
import "side_menu_tile.dart";
import "../models/rive_asset.dart";

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        width: 288, 
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 16, 43, 80),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), 
            bottomRight: Radius.circular(30))
            ),
        padding: const EdgeInsets.only(top: 26, bottom: 26),
        child: Column(
          children: [
            InfoCard(
              name: "Andreas Sahlin", 
              craft: "Knitter & crocheter"),
            ...sideMenus.map(
              (menu) => SideMenuTile(
                menu: menu, 
              onPress: () {
                menu.input!.change(true);
                Future.delayed(const Duration(seconds: 1), () {
                  menu.input!.change(false);
                  }
                  );
              }, 
              riveonInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(artboard, 
                stateMachineName: menu.stateMachineName);
                menu.input = controller.findSMI("active");
              }, 
              isActive: false)
            )
          ])
        
      ),
    );
  }
}