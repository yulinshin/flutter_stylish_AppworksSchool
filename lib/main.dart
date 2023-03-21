import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        flexibleSpace: Container(
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Image_Logo.png'),
                  fit: BoxFit.fitHeight)),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
        child: BannerSection()
      ),
    );
  }
}

class BannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            CardGenerator(
              url:
                  'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
            ),
            CardGenerator(
                url:
                    'https://images.pexels.com/photos/996329/pexels-photo-996329.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
            CardGenerator(
              url:
                  'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
            ),
          ],
        );
  }
}

class CardGenerator extends StatelessWidget {
  const CardGenerator({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        url,
        height: 200,
        width: 400,
        fit: BoxFit.fill,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
