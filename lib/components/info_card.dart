import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, required this.name, required this.craft,
  });

  final String name;
  final String craft;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Icons.person_outline, color: Colors.white,),
        ),
        title: Text(name, 
        style: const TextStyle(color: Colors.white),),
        subtitle: Text(craft, 
        style: const TextStyle(color: Colors.white, fontSize: 11),),
    );
  }
}