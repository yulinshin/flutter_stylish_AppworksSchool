import 'package:flutter/material.dart';
import 'package:flutter_stylish/productCardGenerator.dart';
import 'BannerGenerator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Model/prdouct.dart';
import 'Model/prdouctCubit.dart';
import 'Model/hotCubit.dart';
import 'Model/hot.dart';
import 'collapsibleList.dart';
import 'package:flutter/foundation.dart';
import 'detailPage.dart';
import 'package:provider/provider.dart';

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HotCubit>(create: (_) => HotCubit()),
        Provider<ProductCubit>(create: (_) => ProductCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/images/Image_Logo.png',
            fit: BoxFit.contain,
            height: 30,
          ),
          centerTitle: true,
        ),
        body: ResponsiveLayoutWidget(),
      ),
    );
  }
}

class ResponsiveLayoutWidget extends StatefulWidget {
  @override
  _ResponsiveLayoutWidgetState createState() => _ResponsiveLayoutWidgetState();
}

class _ResponsiveLayoutWidgetState extends State<ResponsiveLayoutWidget> {
  late Future<void> hotData;
  late Future<void> productData;

  @override
  void initState() {
    super.initState();
    hotData = context.read<HotCubit>().getHotData();
    productData = context.read<ProductCubit>().getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: Future.wait([hotData, productData]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else {
          final List<dynamic> data = snapshot.data!;
          final List<Hot> hotList = data[0];
          final List<ProductCategory> productCategories = data[1];
          if (screenWidth < 600) {
            return Column(
              children: [
                BannerSection(hotList: hotList),
                Expanded(child: CollapsibleHeaderList(data: productCategories)),
              ],
            );
          } else {
            return Column(
              children: [
                BannerSection(hotList: hotList),
                Expanded(child: HorizontalProductList(data: productCategories)),
              ],
            );
          }
        }
      },
    );
  }
}

class BannerSection extends StatefulWidget {
  final List<Hot> hotList;

  const BannerSection({required this.hotList});

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
            BannerGenerator(url: widget.hotList[0].imageUrl),
            BannerGenerator(url: widget.hotList[1].imageUrl),
            BannerGenerator(url: widget.hotList[2].imageUrl),
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

List<ProductInfo> generateObjects(int count) {
  List<ProductInfo> objects = [];
  for (int i = 0; i < count; i++) {
    objects.add(ProductInfo(
        id: 32,
        productName: "3333",
        productPrice: 300,
        productPicUrl:
            'https://images.pexels.com/photos/325876/pexels-photo-325876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'));
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
