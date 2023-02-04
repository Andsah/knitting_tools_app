import "package:rive/rive.dart";
export './rive_asset.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title});

  setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset("assets/rive/yarn_icons.riv",
      artboard: "YARNBALL",
      stateMachineName: "YARNBALL", // dude spelled it with a lower case I...
      title: "Home"),
  RiveAsset("assets/rive/animated_icon_set.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Stitch calculators"),
  RiveAsset("assets/rive/animated_icon_set.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "Row counter"),
  RiveAsset("assets/rive/animated_icon_set.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
      title: "To be determined..."),
];
