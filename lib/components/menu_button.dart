import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.press,
    required this.riveOnInit,
  });

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(8),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 2), blurRadius: 8)
              ]),
          child: RiveAnimation.asset(
            "assets/rive/sidemenu_icon.riv",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
