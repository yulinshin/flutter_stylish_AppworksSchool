import 'dart:html';

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
        title: Image.asset('assets/images/Image_Logo.png',
            fit: BoxFit.contain, height: 30),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BannerSection(),
          // Expanded(
          //     child: SingleChildScrollView(
          //   padding: EdgeInsets.all(20),
          //   scrollDirection: Axis.vertical,
          //   child: PorductSection(),
          //   )
          // ),
          Expanded(child: ProductListSection())
        ],
      ),
    );
  }
}

class BannerSection extends StatefulWidget {
  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  double _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: _scrollOffset),
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        child: Row(
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
        ),
        onHorizontalDragUpdate: (details) {
          setState(() {
            _scrollOffset -= details.delta.dx;
          });
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            _scrollOffset = 0.0;
          });
        },
      ),
      padding: const EdgeInsets.all(20),
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

class ProductInfo {
  String productName;
  int productPrice;
  String productPicUrl;
  ProductInfo(this.productName, this.productPrice, this.productPicUrl);
}

class ProductListSection extends StatelessWidget {
  final List<ProductInfo> cat1Proucts = [
    ProductInfo('ProductName1', 100,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName2', 200,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName3', 300,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName4', 400,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName5', 500,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName6', 600,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName7', 700,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName8', 800,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName9', 900,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
  ];
  final List<ProductInfo> cat2Proucts = [
    ProductInfo('ProductName1', 100,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName2', 200,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName3', 300,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName4', 400,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName5', 500,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName6', 600,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName7', 700,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName8', 800,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName9', 900,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
  ];
  final List<ProductInfo> cat3Proucts = [
    ProductInfo('ProductName1', 100,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName2', 200,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName3', 300,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName4', 400,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName5', 500,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName6', 600,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName7', 700,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName8', 800,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    ProductInfo('ProductName9', 900,
        'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
  ];

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 800;
    return Row(
      children: isScreenWide ? [Flexible(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: cat1Proucts.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCardGenerator(
              productName: cat1Proucts[index].productName,
              productPicUrl: cat1Proucts[index].productPicUrl,
              productPrice: cat1Proucts[index].productPrice,
            );
          }
        ),
      ),
      Flexible(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: cat2Proucts.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCardGenerator(
              productName: cat2Proucts[index].productName,
              productPicUrl: cat2Proucts[index].productPicUrl,
              productPrice: cat2Proucts[index].productPrice,
            );
          }
        ),
      ),
      Flexible(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: cat3Proucts.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCardGenerator(
              productName: cat3Proucts[index].productName,
              productPicUrl: cat3Proucts[index].productPicUrl,
              productPrice: cat3Proucts[index].productPrice,
            );
          }
        ),
      )
      ] : [Flexible(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: (cat1Proucts + cat2Proucts + cat3Proucts).length,
          itemBuilder: (BuildContext context, int index) {
            return ProductCardGenerator(
              productName: (cat1Proucts + cat2Proucts + cat3Proucts)[index].productName,
              productPicUrl: (cat1Proucts + cat2Proucts + cat3Proucts)[index].productPicUrl,
              productPrice: (cat1Proucts + cat2Proucts + cat3Proucts)[index].productPrice,
            );
          }
        ),
      )]
    );
  }
}

class PorductSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 800;

    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      clipBehavior: Clip.hardEdge,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(child: CategorySection(categoryTitle: '女裝')),
        Flexible(child: CategorySection(categoryTitle: '男裝')),
        Flexible(child: CategorySection(categoryTitle: '配件'))
      ],
    );
  }
}

class CategorySection extends StatelessWidget {
  const CategorySection({
    required this.categoryTitle,
  });

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(categoryTitle),
        ProductCardGenerator(
          productName: "ProductName",
          productPicUrl:
              "https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          productPrice: 123,
        ),
        ProductCardGenerator(
          productName: "ProductName",
          productPicUrl:
              "https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          productPrice: 123,
        ),
        ProductCardGenerator(
          productName: "ProductName",
          productPicUrl:
              "https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          productPrice: 123,
        ),
        ProductCardGenerator(
          productName: "ProductName",
          productPicUrl:
              "https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          productPrice: 123,
        )
      ],
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
                  child: Text(
                    productName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'NT\$ $productPrice',
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
