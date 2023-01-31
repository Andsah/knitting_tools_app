import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knitting tools',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColorDark: Colors.indigo,
          primaryColorLight: Colors.indigo,
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.quicksandTextTheme()
      ),
      home: const MyHomePage(title: 'Hello, knitter!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: ListTile.divideTiles(
          context: context,
          tiles: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile( style: ListTileStyle.drawer,
              title: const Text('Increase evenly calculator'),
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('Decrease evenly calculator'),
              onTap: () {

              },
            ),
          ListTile(
          title: const Text('Count rows/rounds'),
        onTap: () {

        },
          )]).toList(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
