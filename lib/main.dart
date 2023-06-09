import 'package:flutter/material.dart';
import 'package:flutter_stylish/productCardGenerator.dart';
import 'BannerGenerator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Product/prdouct.dart';
import 'Product/prdouctCubit.dart';
import 'Model/hotCubit.dart';
import 'Model/hot.dart';
import 'collapsibleList.dart';
import 'package:flutter/foundation.dart';
import 'detailPage.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const MyHomePage(),
//     );
//   }

  
// }

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
        Provider<ProductCategoryCubit>(create: (_) => ProductCategoryCubit()),
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
    productData = context.read<ProductCategoryCubit>().getProductsData();
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
