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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
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
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Image_Logo.png'),
                  fit: BoxFit.fitHeight)),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              child: BannerSection()),
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            scrollDirection: Axis.vertical,
            child: ProductCardGenerator(
              productName: "ProductName",
              productPicUrl: "https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              productPrice: 123,
              ),
          )
        ],
      ),
    );
  }
}

class BannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BannerGenerator(
          url:
              'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ),
        BannerGenerator(
            url:
                'https://images.pexels.com/photos/996329/pexels-photo-996329.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
        BannerGenerator(
          url:
              'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ),
      ],
    );
  }
}

class BannerGenerator extends StatelessWidget {
  const BannerGenerator({
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

class ProductCardGenerator extends StatelessWidget {
 
  const ProductCardGenerator({
    required this.productName,
    required this.productPrice,
    required this.productPicUrl,
  });
 
  final String productName;
  final int productPrice;
  final String productPicUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Image.network(
           productPicUrl,
           height: 100,
           width: 80,
           fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Text(productName,
                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Text('NT\$ $productPrice',
                 style: TextStyle(fontSize: 16),
                 ),
               ),
              ],  
            ),
          ),
        ], 
      ),
      shape: RoundedRectangleBorder(
         side: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
