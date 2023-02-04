import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knitting_tools_app/components/side_menu.dart';
import 'package:knitting_tools_app/screens/calc_screen.dart';
import 'package:knitting_tools_app/utils/rive_utils.dart';
import 'package:rive/rive.dart';

import 'components/menu_button.dart';
import 'models/rive_asset.dart';

void main() {
  runApp(const KnittingApp());
}

class KnittingApp extends StatelessWidget {
  const KnittingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knitting tools',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColorDark: Colors.indigo,
          primaryColorLight: Colors.indigo,
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.quicksandTextTheme()),
      home: const KnittingHomePage(),
    );
  }
}

class KnittingHomePage extends StatefulWidget {
  const KnittingHomePage({super.key});

  @override
  State<KnittingHomePage> createState() => _KnittingHomePageState();
}

class _KnittingHomePageState extends State<KnittingHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController slideAnimationController;
  late Animation<double> slideAnimation;
  late Animation<double> scaleAnimation;

  // For the Rive asset and SideMenu widget respectively.
  late SMIBool isSideMenuOpen;
  bool sideMenuOpen = false;
  String chosenMenu = "Home";

  // Background image for funsies
  int bgImage = Random().nextInt(5);

  Map<String, Widget> screens = {
    "Stitch calculators": const CalcScreen(),
  };

  @override
  void initState() {
    slideAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    slideAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: slideAnimationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: slideAnimationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 10) {
            if (!sideMenuOpen) {
              changeSideMenuState();
            }
          }

          // Swiping in left direction.
          if (details.delta.dx < -10) {
            if (sideMenuOpen) {
              changeSideMenuState();
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/${bgImage.toString()}.jpg"),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                width: 288,
                left: sideMenuOpen ? 0 : -288,
                height: MediaQuery.of(context).size.height,
                child: SideMenu(
                    callback: (menu) => setState(() => chosenMenu = menu)),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(slideAnimation.value -
                      30 * pi * slideAnimation.value / 180),
                child: Transform.translate(
                  offset: Offset(slideAnimation.value * 265, 0),
                  child: Transform.scale(
                    scale: scaleAnimation.value,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.zero,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          color: Colors.white,
                          child: screens[chosenMenu],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                top: 16,
                left: sideMenuOpen ? 220 : 0,
                child: MenuButton(
                  press: changeSideMenuState,
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: "menuState");
                    isSideMenuOpen = controller.findSMI("isOpen") as SMIBool;
                    isSideMenuOpen.value = false;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeSideMenuState() {
    isSideMenuOpen.value = !isSideMenuOpen.value;
    setState(() {
      sideMenuOpen = !sideMenuOpen;
    });
    if (sideMenuOpen) {
      slideAnimationController.forward();
    } else {
      slideAnimationController.reverse();
    }
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
