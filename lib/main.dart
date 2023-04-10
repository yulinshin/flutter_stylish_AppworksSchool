import 'package:flutter/material.dart';
import 'package:flutter_stylish/productCardGenerator.dart';
import 'prdouctModel.dart';
import 'collapsibleList.dart';
import 'package:flutter/foundation.dart';
import 'detailPage.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/images/Image_Logo.png',
              fit: BoxFit.contain, height: 30),
          centerTitle: true,
        ),
        body: ResponsiveLayoutWidget());
  }
}

class ResponsiveLayoutWidget extends StatelessWidget {
  final List<ProductCategory> data = [
    ProductCategory('男裝', generateObjects(4)),
    ProductCategory('女裝', generateObjects(6)),
    ProductCategory('飾品', generateObjects(10)),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return Column(
        children: [
          BannerSection(),
          Expanded(child: CollapsibleHeaderList(data: data)),
        ],
      );
    } else {
      return Column(
        children: [
          BannerSection(),
          Expanded(child: HorizontalProductList(data: data)),
        ],
      );
    }
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

List<ProductInfo> generateObjects(int count) {
  List<ProductInfo> objects = [];
  for (int i = 0; i < count; i++) {
    objects.add(
      ProductInfo('ProductName1', 100,
          'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    );
  }
  return objects;
}

class HorizontalProductList extends StatelessWidget {
  final List<ProductCategory> data;

  const HorizontalProductList({required this.data});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 3;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final ProductCategory category = data[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                width: itemWidth,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: category.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ProductInfo product = category.products[index];
                    return ProductCardGenerator(model: product);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
